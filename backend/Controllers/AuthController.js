import UserModel from "../Modals/UserModel";
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
        const token = jwt.sign({
            username: user.username,
            user: user._id
        }, process.env.JWT_KEY, { expiresIn: '1h' })
        // jwt token response send to user which expires in 1 hour
        res.status(200).json({ user, token })
    } catch (error) {
        res.status(500).json({ message: error.message })
    }
}

export const loginUser = async (req, res) => {
    res.status(200).json("User LoginUser");
}