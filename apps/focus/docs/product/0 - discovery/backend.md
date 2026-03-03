# Why

We need a simple, straightforward solution for real time communication accross multiple devices.

# Ideas

- I am a lot about degoogling, decentralized computing, etc. But thinking about the familiariy and simplicity of firebase - specially for prototyiping stuff - This would be my go to solution.
- The only constrain here is cost, and that's important - because we will produce a lot of data. 
- Another alternative is google sheets - which also comes in handy in data - and I already pay for a lot of storage. However, I see that not scaling well.
- Building very custom solutions is an option, with AI it isn't very complex. But what bothers me the most is the "real-data". The firebase streaming solution is a killer for me.
- So unless cost become restrictive in the near future, this would be the go to solution. We still need to test if it works well on linux, but well, I think so.
- Let's of course create every layer possible agnostic so we can switch easily to another solution in the future.

# Crazy idea: TV as server

- Well, the most viable solution is indeed using a linux computer for providing the UI for the TV. Why not consider it as the server? 
- It is indeed very handy because it already would receive everything from the devices, but there are some caveats:
- It's a one way solution. How would we send back to the other devices the real data?
- It's very custom and we centralize everything in one place. Doesn't seem a good thing to do now. I like the idea of having a home server, but again, this isn't the focus now.

# Final thoughts:

I think we need to move in direction of home server in the future, but let's take baby steps. Maybe it can be in the near future - 2,3 months. But not for now. Let's do a simple solution, even if it costs a bit - and make everything to migrate out of it as soon as possible.