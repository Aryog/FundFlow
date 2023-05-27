import UserModel from "../Modals/UserModel.js";
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import nodemailer from 'nodemailer'

// Register request handle function
export const registerUser = async (req, res) => {
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt)
    req.body.password = hashedPassword;
    const newUser = new UserModel(req.body)
    const { email } = req.body
    try {
        // check if already registered
        const oldUser = await UserModel.findOne({ email });
        if (oldUser) {
            return res.status(400).json({ message: "User with this email already exists!" });
        }
        const user = await newUser.save();
        const accessToken = generateAccessToken(user);
        const refreshToken = generateRefreshToken(user);
        // jwt token response send to user which expires in 1 hour
        res.status(200).json({ user, accessToken, refreshToken })
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

// Login request handle function
export const loginUser = async (req, res) => {
    const { username, password } = req.body;
    try {
        const user = await UserModel.findOne({ username: username });
        if (user) {
            const validity = await bcrypt.compare(password, user.password)
            if (!validity) {
                res.status(400).json({ message: "Wrong Password!" })
            } else {
                const accessToken = generateAccessToken(user);
                const refreshToken = generateRefreshToken(user);
                res.status(200).json({ user, accessToken, refreshToken });
            }
        } else {
            res.status(404).json("User doesn't exist!")
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

const generateAccessToken = (user) => {
    return jwt.sign({ id: user._id, user: user.username }, process.env.JWT_ACCESS_SECRET, { expiresIn: '15m' });
};

const generateRefreshToken = (user) => {
    return jwt.sign({ id: user._id, user: user.username }, process.env.JWT_REFRESH_SECRET, { expiresIn: '7d' });
};

// for verification send mail link
export const sendVerificationLink = async (req, res) => {
    try {
        const { email } = req.body;
        const userData = await UserModel.findOne({ email });
        if (userData) {
            sendVerifyMail(userData.username, email, userData._id);
            res.status(200).json({ message: "Verification link sent successfully" })
        } else {
            res.status(404).json({ message: "User not found please check you mail" })
        }
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

export const verifyUser = async (req, res) => {
    try {
        // i need here to change the state of isVerified Database state
        const _id = req.query.id
        const userData = await UserModel.findOne({ _id });
        if (userData.is_verified === false) {
            await UserModel.updateOne({ _id: _id }, { $set: { is_verified: true } });
            res.status(200).json({ message: `Verification of ${userData.username} successfull` });
        } else {
            res.status(400).json({ message: `${userData.username} is already verified` });
        }
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

export const getAccessToken = async (req, res) => {
    try {
        const refreshToken = req.body.refreshToken.split(" ")[0];

        // Verify and decode the refresh token
        jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET, (err, decoded) => {
            if (err) {
                // Handle refresh token verification error (e.g., token expired, invalid signature)
                return res.status(401).json({ error: 'Invalid refresh token' });
            }

            // Extract the necessary information from the refresh token, such as the user ID
            const userId = decoded.id;

            // Generate a new access token
            const accessToken = jwt.sign({ id: userId }, process.env.JWT_ACCESS_SECRET, { expiresIn: '15m' });

            // Send the new access token as a response
            res.status(200).json({ accessToken });
        });
    } catch (error) {
        res.status(500).json({ message: error });
    }
}

async function sendVerifyMail(username, email, _id) {
    // Generate test SMTP service account from ethereal.email
    // Only needed if you don't have a real mail account for testing
    let testAccount = await nodemailer.createTestAccount();

    // create reusable transporter object using the default SMTP transport
    let transporter = nodemailer.createTransport({
        host: "smtp.ethereal.email",
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
            user: "cecile.wisozk@ethereal.email", // generated ethereal user
            pass: 'MKufvFDu59ZerxSjyn', // generated ethereal password
        },
    });

    // send mail with defined transport object
    let info = await transporter.sendMail({
        from: '"Fund Flow 👻" <cecile.wisozk@ethereal.email>', // sender address
        to: `${email}`, // list of receivers
        subject: `For verification of fundflow account ✔`, // Subject line
        text: "Hello world?", // plain text body
        html: `<p>Hi ${username}, please click here to <a href="http://localhost:5000/auth/verify?id=${_id}" target="_blank"> Verify </a> your mail.</p>`, // html body
    });

    console.log("Message sent: %s", info.messageId);
    // Message sent: <b658f8ca-6296-ccf4-8306-87d57a0b4321@example.com>

    // Preview only available when sending through an Ethereal account
    console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
    // Preview URL: https://ethereal.email/message/WaQKMgKddxQDoou...
}