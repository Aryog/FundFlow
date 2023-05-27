import express from 'express';
import { loginUser, registerUser, verifyUser, sendVerificationLink, getAccessToken } from '../Controllers/AuthController.js';
const router = express.Router()

router.get('/', async (req, res) => {
    res.send("Auth Route")
});

router.post('/register', registerUser);
router.post('/login', loginUser);
router.get('/verify', verifyUser);
router.post('/verify', sendVerificationLink);
router.post('/refresh-token', getAccessToken);
export default router;