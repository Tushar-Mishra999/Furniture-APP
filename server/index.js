const express= require('express');
const mongoose=require('mongoose');
const app=express();
const PORT=3000;
const productRouter=require('./router/product');
const DB="mongodb+srv://Tushar:password1234@cluster0.h7ewkxp.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());
app.use(productRouter);
mongoose.connect(DB).then(()=>{
    console.log("Mongo Connection Successful");
}).catch((e)=>{console.log(e);})

app.listen(PORT,()=>{
    console.log(`connected at port ${PORT}`);
})
