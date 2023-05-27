import mongoose from "mongoose";
const RecordSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users'
    },
    type: {
        type: String,
        require: true
    },
    amount: {
        type: Number,
        require: true,
    },
    category: {
        type: String,
        require: true,
    },
    account: {
        type: String,
        require: true,
    },
    remarks: {
        type: String,
        require: true,
        default: ""
    }
}, { timestamps: true })

const RecordModel = mongoose.model('records', RecordSchema);
export default RecordModel;