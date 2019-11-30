# Urban Dictionary Unofficial App 
An urban dictionary app showing urban definitions for slang, lightweight, decent looking and totally ads free.

## Get it on Google Play Store

[You can download it and view it from here](https://play.google.com/store/apps/details?id=com.pocean.urban_dict_slang)

### Packages used: 
1. [Http to connect to API](https://pub.dev/packages/http)
2. [BloC and Flutter BloC for state management](https://pub.dev/packages/bloc)
3. [Moor for database ORM](https://pub.dev/packages/moor)
4. [Flare Splash Screen for animating splash screen](https://pub.dev/packages/flare_splash_screen)
5. [Sticky Headers to create the sticky headers for history page](https://pub.dev/packages/sticky_headers)
6. [Flutter launcher icons to automate creating launcher icons](https://pub.dev/packages/flutter_launcher_icons)

### Architecture used
- First, I used Provider package for Dependency Injection of repositories and called their methods in UI but it was messy (dirty), I wanted a cleaner architecture.

- Secondly, I tried to Follow [FilledStacks](https://www.filledstacks.com/) architecture for [provider v3 using a MVVM architecture](https://www.filledstacks.com/post/flutter-provider-v3-architecture/) but found it quite cumbersome for my taste (I am still a novice, maybe I just don't know how to utilize it well).
- Then, I switched to BloC architecture using the bloc/fluter_bloc libraries and it was a breeze.
#### Screenshots
1. Search page 
![Search page SC](https://imgur.com/2RGuh06.png)
2. History Page
![History Page SC](https://imgur.com/cgKoFPh.png)
3. Favorites Page
![Favorites Page SC](https://imgur.com/QqwE4Kg.png)