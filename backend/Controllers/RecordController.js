import RecordModel from "../Modals/RecordModel.js";

export async function getAllRecordOfUser(req, res) {
    try {
        const records = await RecordModel.find({ user: req.userId })
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

}
export async function updateUserRecord(req, res) {

}