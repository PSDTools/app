# Riverpod Graph

## Graph

```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px;
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px;
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end

  routerProvider[["routerProvider"]];
  gpaServiceProvider[["gpaServiceProvider"]];
  userProvider[["userProvider"]];
  pirateAuthServiceProvider[["pirateAuthServiceProvider"]];
  nameProvider[["nameProvider"]];
  emailProvider[["emailProvider"]];
  avatarProvider[["avatarProvider"]];
  accountTypeProvider[["accountTypeProvider"]];
  idProvider[["idProvider"]];
  avatarProvider[["avatarProvider"]];
  avatarsProvider[["avatarsProvider"]];
  authProvider[["authProvider"]];
  accountsProvider[["accountsProvider"]];
  currentPlatformProvider[["currentPlatformProvider"]];
  deviceInfoProvider[["deviceInfoProvider"]];
  deviceUtilsProvider[["deviceUtilsProvider"]];
  bannerConfigProvider[["bannerConfigProvider"]];
  appletsProvider[["appletsProvider"]];
  dashboardServiceProvider[["dashboardServiceProvider"]];
  currentStageProvider[["currentStageProvider"]];
  currentUserCoinsProvider[["currentUserCoinsProvider"]];
  coinsServiceProvider[["coinsServiceProvider"]];
  coinsDataProvider[["coinsDataProvider"]];
  databasesProvider[["databasesProvider"]];
  clientProvider[["clientProvider"]];
  App((App));
  GpaPage((GpaPage));
  AuthPage((AuthPage));
  DeviceBanner((DeviceBanner));
  _GetContent((_GetContent));
  _ExpandedWrapper((_ExpandedWrapper));
  _Applets((_Applets));
  _AppletButton((_AppletButton));
  PirateCoinsPage((PirateCoinsPage));
  _TeacherView((_TeacherView));
  _StudentView((_StudentView));
  _MutationBar((_MutationBar));
  _UserForm((_UserForm));
  StatsPage((StatsPage));

  routerProvider -.-> App;
  gpaServiceProvider ==> GpaPage;
  gpaServiceProvider -.-> GpaPage;
  gpaServiceProvider -.-> GpaPage;
  pirateAuthServiceProvider -.-> AuthPage;
  pirateAuthServiceProvider -.-> AuthPage;
  bannerConfigProvider ==> DeviceBanner;
  deviceInfoProvider ==> _GetContent;
  nameProvider ==> _ExpandedWrapper;
  emailProvider ==> _ExpandedWrapper;
  appletsProvider ==> _Applets;
  currentStageProvider -.-> _AppletButton;
  accountTypeProvider ==> PirateCoinsPage;
  currentStageProvider ==> _TeacherView;
  coinsServiceProvider ==> _TeacherView;
  currentUserCoinsProvider ==> _StudentView;
  coinsServiceProvider -.-> _MutationBar;
  coinsServiceProvider -.-> _MutationBar;
  currentStageProvider -.-> _UserForm;
  currentUserCoinsProvider ==> StatsPage;
  pirateAuthServiceProvider ==> userProvider;
  userProvider ==> nameProvider;
  userProvider ==> emailProvider;
  userProvider ==> accountTypeProvider;
  userProvider ==> idProvider;
  accountsProvider ==> authProvider;
  currentPlatformProvider ==> authProvider;
  clientProvider ==> accountsProvider;
  deviceUtilsProvider ==> deviceInfoProvider;
  currentPlatformProvider ==> deviceUtilsProvider;
  dashboardServiceProvider ==> appletsProvider;
  pirateAuthServiceProvider ==> currentUserCoinsProvider;
  coinsServiceProvider -.-> currentUserCoinsProvider;
  databasesProvider ==> coinsDataProvider;
  clientProvider ==> databasesProvider;

  userProvider -.-> routerProvider;
  authProvider -.-> pirateAuthServiceProvider;
  avatarProvider1 ==> _ExpandedWrapper;
  userProvider ==> avatarProvider1;
  avatarsProvider ==> avatarProvider;
  clientProvider ==> avatarsProvider;
  avatarProvider ==> authProvider;
  coinsDataProvider -.-> coinsServiceProvider;
```

## How to Regenerate

1. From the root of this repo, move out of this repo: `cd ..`.
1. Clone the riverpod repo, and enter it: `git clone https://github.com/rrousselGit/riverpod.git && cd riverpod`.
1. Enter the `riverpod_graph` directory, and activate it: `cd packages/riverpod_graph && dart pub global activate -s path .`.
1. Enter the app directory again, and run `riverpod_graph`: `cd ./../../../app/ && riverpod_graph .`.
1. Copy and paste the output into here.
1. Remove all references to `avatarsProvider` and `avatarProvider`, and then append this to the end:

   ````md
   ```mermaid
    userProvider -.-> routerProvider;
    authProvider -.-> pirateAuthServiceProvider;
    avatarProvider1 ==> _ExpandedWrapper;
    userProvider ==> avatarProvider1;
    avatarsProvider ==> avatarProvider;
    clientProvider ==> avatarsProvider;
    avatarProvider ==> authProvider;
    coinsDataProvider -.-> coinsServiceProvider;
   ```
   ````
