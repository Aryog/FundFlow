import express from 'express';
import bodyParser from 'body-parser';
import mongoose from 'mongoose';
import dotenv from "dotenv";
import cors from 'cors'
import AuthRoute from "./Routes/AuthRoute.js"
import RecordRoute from "./Routes/RecordRoute.js"


dotenv.config();
const app = express();

// Middlewares for security purpose
app.use(bodyParser.json({ limit: '30mb', extended: true }))
app.use(bodyParser.urlencoded({ limit: '30mb', extended: true }))

// To remove the cross origin issue
app.use(cors());

const URI = process.env.MONGO_DB;

// Connecting the mongodb
mongoose.connect(URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => app.listen(process.env.PORT, () => console.log('Server listening at Port:', process.env.PORT)))
    .catch((error) => console.log(error));


app.get("/", (req, res) => {
    res.status(200).send("Hello Welcome yogesh 👋");
})

app.use('/auth', AuthRoute);

// To-do add the user details firstly to be implemented without middleware
app.use('/record', RecordRoute);