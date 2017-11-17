# Caculator, Basic UIkit, and MLkit
> This iOS app development is my second iOS app which uses basic UIkit components and Apple new technology in MLkit
> There are some reference links, if you want more detail knowledges in MLkit, you can follow the links below.
> link1: [APPCODA MLkit Intro](https://www.appcoda.com/coreml-introduction/)</br>
> link2: [Introducing Core ML - WWDC2017](https://developer.apple.com/videos/play/wwdc2017/703/)</br>
> link3: [Core ML in depth - WWDC2017](https://developer.apple.com/videos/play/wwdc2017/710/)</br>

First, I am going to show you the complete app product, so you can see the pictures below.</br>
I use tabView to spilt Caculator, Currency converter, and MLkit demo into three different view.</br>
You can use different tab to try three different functions in the app.
<p align="center">
<img alt="Calculator" src="https://github.com/HermesKeng/Caculator/blob/master/image/Caculator.png" width="200"><img alt="Currency Converter" src="https://github.com/HermesKeng/Caculator/blob/master/image/Currency%20Converter.png" width="200"><img alt="MLkit Demo" src="https://github.com/HermesKeng/Caculator/blob/master/image/MLkit.png" width="200">
</p></br>

These is first glimpse of our app. Now I am going to take about our app in more deeper way.</br>
- **At first, I want to talk about MLkit.** Apple announce the MLkit in WWDC 2017 this year. It helps app developer build app with Machine Learning in easier way.</br>
- You only need to download the machine learning model what you want, convert it into *.mlmodel*, and import it to Xcode. Next,you have to let input data transform to specific format. You can start to predict the object.</br> 
- MLkit supports many different kinds of appication, such as image detection, semantic analysis... and so on. 
You can see the below picture, it is talking about what input data type supports in the MLkit, and what is the data type you have to be converted into before predicting</br>

<p align="center">
<img alt="MLkit Flow" src="https://github.com/HermesKeng/Caculator/blob/master/image/MLmodelFlow.png" >
</p></br>

From picture previously show, we can see each input has its own specific input data type. For this project, we are going to make a image detection, so **we are going to transform the UIimage type to the CVPixelBuffer** later. Before we begin programming, I want to talk about MLmodel. </br>
- MLmodel : It is the file format built by Apple and used for MLKit.
  - In this project you can download the model from the [Apple Developer MLKit Website](https://developer.apple.com/machine-learning/)
  - You also can build the MLModel by yourself, but we don't talk how to build MLModel now.
  - When you download the image mlmodel, you can open it with your Xcode, and you can see the information about your model.
  <p align="center">
  <img alt="Xcode MLKit information" src="https://github.com/HermesKeng/Caculator/blob/master/image/XcodeInfo.jpeg" >
  </p></br>
    The picture above introduce the information in Xcode after opening the MLModel. You can see the basic description, and the input and output data type for the image. You have to follow the information it gives, and you can use the model in your app.

After you know the input format and detailed information in your app. We can start to build our app, and in your mind, you must have the below process when you design the program
  
 1. Select the image from photo library
 2. Transform the UIimage object into specific CVPixelBuffer object (Size is also the same)
 3. Prediction
 4. Display the prediction result





