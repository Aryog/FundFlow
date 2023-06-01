import Express from 'express';
import authMiddleware from '../middlewares/authMiddleware.js';

import { getAllRecordOfUser, createUserRecord, deleteUserRecord, updateUserRecord } from '../Controllers/RecordController.js';
const router = Express.Router();

// middlewares are required but to be implemented later
router.get("/", authMiddleware, getAllRecordOfUser);
router.post("/create", authMiddleware, createUserRecord);
router.delete("/:id", authMiddleware, deleteUserRecord);
router.put("/:id", authMiddleware, updateUserRecord);

export default router;