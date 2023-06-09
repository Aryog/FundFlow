import RecordModel from "../Modals/RecordModel.js";

export async function getAllRecordOfUser(req, res) {
    try {
        const records = await RecordModel.find({ user: req.userId }).sort({ createdAt: -1 })
            .exec();
        res.status(200).json(records);
    } catch (error) {
        res.status(500).json({ message: error });
    }
}
export async function createUserRecord(req, res) {
    try {
        const { type, amount, category, account, remarks, date } = req.body;
        const newRecord = await RecordModel({ type, amount, category, account, remarks, user: req.userId, date })
        const savedRecord = await newRecord.save();
        res.status(200).json(savedRecord)
    } catch (error) {
        res.status(500).json({ message: error });
    }
}
export async function deleteUserRecord(req, res) {
    const recordId = req.params.id;
    const { user } = req.body;
    try {
        const record = await RecordModel.findById(recordId);
        if (record.user == user) {
            await record.deleteOne();
            res.status(200).json({ "message": "Record Deleted Successfully" });
        } else {
            res.status(403).json("Action forbidden!");
        }

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}
export async function updateUserRecord(req, res) {
    const recordId = req.params.id;
    const { user } = req.body;
    try {
        const record = await RecordModel.findById(recordId);
        if (record.user == user) {
            await record.updateOne({ $set: req.body })
            res.status(200).json({ message: "Record Updated" })
        } else {
            res.status(403).json("Action forbidden!");
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}