import Express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';

import { getAllRecordOfUser, createUserRecord, deleteUserRecord, updateUserRecord } from '../Controllers/RecordController.js';
const router = Express.Router();

// router.get("/", async (req, res) => {
//     res.send("Record Route");
// })

// middlewares are required but to be implemented later
router.get("/", authMiddleware, getAllRecordOfUser);
router.post("/create", authMiddleware, createUserRecord);
router.delete("/:id", deleteUserRecord);
router.put("/:id", updateUserRecord);

export default router;