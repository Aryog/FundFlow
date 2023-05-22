import mongoose from "mongoose";

const UserSchema = mongoose.Schema({
    username: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    mobile_number: {
        type: Number,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    is_verified: {
        type: Boolean,
        default: false
    }
},
    { timestamps: true }
)

const UserModel = mongoose.model("Users", UserSchema)
export default UserModel;