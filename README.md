# DeepLaetitia : Deep Reinforcement Learning that makes you smile
![Main picture][1]



# Introduction

The aim of this project is to train a Deep Reinforcement Learning agent to bring a smile to your face.    
The first part of the project was to train a Deep Convoluted Neural Network to predict one of five (happy, neutral, sad, angry, surprised) facial emotions.  
The input to this classifier is taken directly from the user's camera.     
Then, using this prediction as an input, a reinforcement learning agent was trained to make you smile. To do that a customizable emoticon was used. 

## Software requirements
The entire software is written in Wolfram Mathematica 11.1   
Your computer must have **camera**. 


## Why Laetitia?

Laetitia is the Roman Goddess of joy, gaiety, and celebration, and is especially linked with holidays and festivals. 


# Phase one: facial emotion detector
The first phase of the project was to implement the facial emotion detector. 

## Dataset 
The very first part of this phase was dataset selection. I based my study on the Fe.r2013 database.  
It is free and available online on [Kaggle platform][2]. The reason standing behind my choice were small size of training example (pictures 48x48 pixels), huge number of labeled training O(20k) and test O(7k)  examples. Each of database element belongs to one of following classes happy, neutral, sad, angry and surprised.   
Unfortunately, the database is contaminated by noised images or animated faces. It needed lot of afford to manually remove all the useless examples.  

![training examples][3]    

## Model training

At the beginning of my study I trained classical Machine Learning models, such as Supported Vector Machine, Random Forest, k Nearest Neighborhood. These models were used as a performance baseline for further studies based on Deep Convoluted Neural Networks. 
My analysis shows that models that contain two hidden convoluted layers are the best classifiers. A selected model achieved a performance of 91% in happiness recognition, measured as area under Receiver Operating Characteristic curve.  

As mentioned before, the best facial emotion detector is a Deep Convolution Neural Network.  
Above cell presents architecture (upper right plot) of selected network and training progress related plots. 

![CNN training][4]

##  Convoluted Neural Network performance
Classifier performance measurement was performed on O(7k) testing images. 
At first  I present a confusion matrix which is a specific table layout that allows visualization of the performance of an algorithm. Each column of the matrix represents the instances in a predicted class while each row represents the instances in an actual class. The name stems from the fact that it makes it easy to see if the system is confusing two classes (i.e. commonly mislabelling one as another).
![cm][5]

Another widely used classifier performance measuring metrics is the area under the Receiver Operating Characteristic curve, which can be interpreted as equal to the probability that a classifier will rank a randomly chosen positive instance higher than a randomly chosen negative one.  
The obtained results for particular classes:
 ![rocs][6]
## Classifier evaluation

The crucial project constraint is classifier evaluation time. The classifier need to be able to return response in real time. Here you find sample. The delays are caused by gif segmentation.  

![sample][7]

## Transfer learning approach
I also tried to use idea of transfer learning. Roughly speaking, we take pre-trained  model such as [VGG16](http://www.robots.ox.ac.uk/~vgg/research/very_deep/) or [Inception](https://arxiv.org/abs/1512.00567) and then replace two last layers. 

    emotionTypes = {"happy", "neutral", "sad", "angry", "surprise"}
    deepCNN = NetModel["Wolfram ImageIdentify Net for WL 11.1"]
    truncatedNetwork = Take[deepCNN, {1, -3}];
    deepCNNInceptionV3 = 
     NetInitialize @
      NetChain[{truncatedNetwork, LinearLayer[Length[emotionTypes]], 
        SoftmaxLayer[]},
       "Output" -> NetDecoder[{"Class", emotionTypes}]
      ]

Unfortunately, due to technical limitation of my notebook (no GPU unit) I was not able to finish training that kind of model. It probably will perform better than shallow version. This idea will be implemented in the future release of the project.  

# Phase Two: Reinforcement Learning
In this phase, based on chosen model prediction, the policy to find the funniest emoticon was obtained. To do it the Monte Carlo based searching method was applied. 
At first I would like to present tunable emoticon that was used to make you smile. The animation was taken from [Wolfram Demonstration Project site](http://demonstrations.wolfram.com/SmileyChanger/).

 ![emoticon][8] 

This element will be replaced into auto generated pictures or jokes in the future release. 
## Monte Carlo optimization 

Monte Carlo methods (or Monte Carlo experiments) are a broad class of computational algorithms that rely on repeated random sampling to obtain numerical results. Their essential idea is using randomness to solve problems that might be deterministic in principle.

From the point of view this work I am using numerical simulation to find the "funniest" emoticon configuration. Please take a look at the simulation sudo code. 

    nFrames = 10;
    currentHappines = 0.;
    previousHappines = 0.; 
    happinessesList = {{r, t , s, a , b, c , ey , er, currentHappines}};
    ResetParameters[];
    
    Dynamic[
     parameter = SelectParameter[];
     previousParamValue = KeepPreviousParameterValue[parameter];
     update =  CalculateParameterUpdate[parameter, step];
     UpdateParmeter[parameter, update];
     
     frame = 0;
     currentHappines = 0.;
     Column[{ animation,
       While[frame < nFrames,
        image = CurrentImage[];
        greyFace = ExtractFaceFromImage[image];
        currentHappines += PredictHappinessProbability[greyFace];
        frame++;
        ];
       currentHappines /= nFrames; image, greyFace, currentHappines, 
       If[currentHappines > previousHappines , 
        previousHappines =  currentHappines, 
        ReloadParameterValue[parameter, previousParamValue]];
       happinessesList = 
        Join [happinessesList, {{r, t , s, a , b, c , ey , er, 
           currentHappines}}];}
      ]
     
     ]
     
 This simulation allows to obtain learning curve like plot and the from them funniest emoticon configuration.
  
 ![learningCurveMC][9]

#Future goals 
From the future perspective the Q-Learning approach will be implemented. A starting point of the further studies will be Monte Carlo tuned policy mentioned before.



The second idea is to replaced shallow version of CNN into pre-trained model. 



####Stay tuned for further improvements!
####I’m happy about any kind of feedback. Please upvote if you like it ;-)


  [1]: http://community.wolfram.com//c/portal/getImageAttachment?filename=Classifier.gif&userId=1075716
  [2]: https://www.kaggle.com/c/challenges-in-representation-learning-facial-expression-recognition-challenge "Kaggle"
  [3]: http://community.wolfram.com//c/portal/getImageAttachment?filename=images.png&userId=1075716
  [4]: http://community.wolfram.com//c/portal/getImageAttachment?filename=trainingResult.png&userId=1075716
  [5]: http://community.wolfram.com//c/portal/getImageAttachment?filename=CM.png&userId=1075716
  [6]: http://community.wolfram.com//c/portal/getImageAttachment?filename=Rocs.png&userId=1075716
  [7]: http://community.wolfram.com//c/portal/getImageAttachment?filename=Reaction.gif&userId=1075716
  [8]: http://community.wolfram.com//c/portal/getImageAttachment?filename=Emoticon.png&userId=1075716
  [9]: http://community.wolfram.com//c/portal/getImageAttachment?filename=MonteCarlo.png&userId=1075716
