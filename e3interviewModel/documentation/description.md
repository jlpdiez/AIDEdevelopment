#Description
This project focuses on the interview to patient E3. 

The patient is an 86 year old female who was diagnosed as having an incipient senility 4 or 5 years ago, when she started noticing she sometimes forgot words and phone numbers.

She lives alone but her two sisters and niece live closeby. Although she is capable of doing almost every day to day chore she is taken care by her small sister and niece who do almost everything for her.

The problems they report she has are the following:

* Sometimes when speaking she forgets words. She is aware of that.
* Routinely forgets dates and times for schedules such as doctors.
* Forgets about tasks she has already done like having breakfast.
* She forgets about ever having been in places like the hospital where she usually goes.
* Has difficulties when she has to take decisions. For example at one time her house flooded and she didn't knew what to do about it.
* Has had mood changes. It is reported that before she was more grumpy but now she seems more calmed and relaxed.
* She has lower energy drive. Nowadays she is more lazy while before she was always doing things.

She is mostly aware of her illness and age and has more or less accepted she is close to death. This results in a better character and humour and giving less importance to small things.

---

Three different simulations have been made that try to mimic some of these symptoms as close as possible. The symptoms are the following:

![alt text](symptoms.png "Symptoms diagram")

---

##Patient sometimes forgets words

For this case we modelled a conversation and made a filter that makes her unable to speak on occasion.

An InteractionDiagram was created that tries to simulate a conversation between both agents.

![alt text](speechInteraction.png "Speech interaction diagram")

The filter for this symptom was implemented using a filter of the type unable with a low probability (0.075) of this event happening.

![alt text](speechFilter.png "Speech filter implementation")

The resulting initialization of the simulation is as follows:

![alt text](speechInit.png "Speech simulation initialization")

---

##Patient is described as having a lower energy drive

In this case we made a simple sequence of getting in & out of bed, moving and using a chair. A filter is then applied that makes these actions take a longer time.

The sequence of movements the agent performs is this:

![alt text](movementSequence.png "Movement sequence diagram")

For this symptom we used a delay filter that makes her act more slowly (50%)

![alt text](movementFilter.png "Movement filter implementation")

The resulting initialization is the following:

![alt text](movementInit.png "Movement simulation initialization")

---

##Patient sometimes forgets a task she was about to perform

For this simulation a sequence of task was constructed that tries to mimic typical actions performed in the morning such as showering. A filter is then applied that cancels some of the tasks that have to be performed.

The movements the agent makes are these:

![alt text](tasksSequence.png "Tasks sequence diagram")

For this symptom we used a replace task filter that changes the task to one in which the agent states out loud she doesn't know what to do. The filter then is:

![alt text](tasksFilter.png "Tasks filter implementation")

To init the simulation we apply the following variables

![alt text](movementInit.png "Movement simulation initialization")

---

##Difficulties encountered

Some issues were encountered when trying to model the interview into the software. The main problem is that a lot of information gets lost along the way as there is no direct way of modelling things such as feelings, thoughts or emotions.

To give an example, there is no easy way of modelling the fact that she used to do a lot of stuff throughout the day whereas she is more "passive" nowadays.

Of all the symptoms the patient and her caregiver describe many would get modelled similarly. For example in the case of forgetting tasks already performed or having difficulties while planning what to do next. Both cases fit pretty well on the "SimTasks" simulation, where one task is replaced by another, as there is no easy way of describing "what's inside her head".

Another example would be in the case of losing oneself at home, which wouldn't be the same as getting lost in a railroad station. In both cases the simulation would be more or less the same, losing all the context and difficulties that would arise in one place or another.

Another problem was in the case of simulating a conversation where the patient forgets a word. Leaving aside the fact that to model speech in which real information is shared would generate countless diagrams, there is also the fact that we are limited to "turning off" the task of speaking, thus losing all the context of trying to find a synonym.

