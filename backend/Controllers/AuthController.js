import UserModel from "../Modals/UserModel.js";
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'

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
    return jwt.sign({ user: user.username, user: user._id }, process.env.JWT_ACCESS_SECRET, { expiresIn: '15m' });
};

const generateRefreshToken = (user) => {
    return jwt.sign({ user: user.username, user: user._id }, process.env.JWT_REFRESH_SECRET, { expiresIn: '7d' });
};