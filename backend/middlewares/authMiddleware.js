import dotenv from 'dotenv'
import jwt from 'jsonwebtoken'
dotenv.config();
// Middleware function to extract user ID from tokens
const authMiddleware = (req, res, next) => {
    // Get the access token and refresh token from the request headers or cookies
    try {

        const accessToken = req.headers.authorization; // Assuming the access token is passed in the "Authorization" header

        // Verify and decode the access token
        jwt.verify(accessToken.split(" ")[0], process.env.JWT_ACCESS_SECRET, (err, decoded) => {
            if (err) {
                // Handle access token verification error (e.g., token expired, invalid signature)
                res.status(401).json({ message: "You are unauthorized or your token expired" });
            }

            // Extract the user ID from the decoded access token payload
            const userId = decoded.id;

            // Attach the user ID to the request object for use in subsequent route handlers
            req.userId = userId;

            // Continue to the next middleware or route handler
            next();
        });
    } catch (error) {
        res.status(500).json({ message: error })
    }
};

// Helper function to handle invalid access token and verify the refresh token
const handleInvalidAccessToken = (req, res, refreshToken) => {
    // Verify and decode the refresh token
    jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET, (err, decoded) => {
        if (err) {
            // Handle refresh token verification error (e.g., token expired, invalid signature)
            return res.status(401).json({ error: 'Invalid refresh token' });
        }

        // Extract the user ID from the decoded refresh token payload
        const userId = decoded.id;

        // Attach the user ID to the request object for use in subsequent route handlers
        req.user._id = userId;

        // Continue to the next middleware or route handler
        next();
    });
};

export default authMiddleware;
