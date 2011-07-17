Storied; an iOS client for the Storify API.

https://github.com/storify/apidoc/wiki/

I believe that git is a great tool for collaboration when editing a common set of resources. As developers we usually think of this in terms of source control but the features offered by git can support powerful patterns of collaboration and we can build on them to empower users of our applications to collaborate in more sophisticated and productive ways. Without necessarily exposing the semantics of git as part of the application.
Storied pulls data from the Storify API and presents it to the user backed by a local git repository. This allows the user to fork other author's work, replay the history of the original author's additional, and add their own contributions.
I would like to see APIs designed around this sort of versioned data so that users could actually issue pull requests to merge contributions and track the network graph of forked stories so that users can watch a discussion evolve, converge, diverge, and change hands among many participants.

Included libraries:

https://github.com/johnezang/JSONKit
https://github.com/pokeb/asi-http-request
https://github.com/zwaldowski/BlocksKit
https://github.com/libgit2/objective-git
https://github.com/libgit2/libgit2