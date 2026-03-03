# Why

Showing the focus system on TV is the primary priority because we have too much space, flexibility and is basically omnipresent on our work-from-home routine.

# How

Three options:

- A: Connect a Work Mac OS: This is the option I'm doing for the moment, just to test things out. Works pretty well most of the times and is very easy to iterate product. However, it has limitations to sound, when turning-off my mac, it stop showing, etc. So I think we should seriously consider another option.

- B: Connect a dedicated Linux computer to the TV, 24/7: I am capable of doing that because I have a Linux PC that is set aside for now. The only limitation would be iterating stuff easily. Also, there might be some overhead of running flutter on linux, hopefully not that much (and I have been wanting to do that some time!)

- C: Create a special App for my TV OS: This seems too far off, because although possible, there might be limitations. Besides, I don't know what it takes to publish, etc. Well, uneeded overhead. In the future, it can be useful, certainly, as showcase. But not the priority.

Given that, the linux is most promising, but not with its challenges. We need to consider deployments and for that we could

A: Create some basic scripting to deploy binaries from anywhere and linux instance stays in sync, no intervetion on machine needed. Interesting solution and probably it should have already something like this.

B: Web solution that we can deploy to some cloud and also deploy the artifact. I think this is plentiful, but I would like to avoid flutter web, as I don't have a full sense of features (what if I want to use system functions, or native push notifications?). Besides, I would need to always have a browser open - that gives me a vibe of workaround. Why not just have a proper application, if you can?

C: We want to iterate fast sometimes and not the hassle of switching between my development computer and the linux computer. We can search for some solution that unified both? However not very clear how that would be. Maybe run the Dart VM server on the local network and connect the debugger in my machine? That is very promising because I could change the code whenever, at least for the first iterations.