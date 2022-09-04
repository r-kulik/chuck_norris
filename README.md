# Chuck-Norris Pet-project
###### Rostislav Kulik, B21-05


A little project with small functionality.
Press "I liked. Next one!" button to get a new joke.
Press heart-button to like a joke.
Switch to favourites screen to remind yourself your favourite jokes.

## Screenshots:
![Main Screen](/img/main_screen.jpg "Main Screen")
![Favourites Screen](/img/favourite_screen.jpg "Favourites Screen")

## Requirements references to help you with checking:
### 1. Assigment 1
#### 1.1 Basic Requirements
##### 1.1.1 Readme with a short description and screenshot(s) of your application
You are reading it right now.
##### 1.1.2 Application builds successfully for Android: working APK (or link to it) is attached to readme
Link is in the end of Readme
##### 1.1.3 Use http or dio for networking to access api.chucknorris.io/jokes/random
In updating_functions.dart, line 22, updateJokesAccordingToCatefory function:
``` dart
http.Response response = await http.get(url);
```
##### 1.1.4 Use all of these widgets: MaterialApp, Scaffold, SafeArea, Column (or Row), Padding
main_application.dart, line 11, ChuckTinderApplication.build function:
``` dart
    return MaterialApp(...);
```
main_page.dart, lines 38-40, MainPage.build function:
``` dart
        child: SafeArea(child: Scaffold(body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(...);
```
main_page.dart, line 54, MainPage.build function:
``` dart
              Padding(padding: EdgeInsets.all(constraints.maxHeight * 0.01)),
```
##### 1.1.5 Use Stateful and Stateless Widget
joke_card.dart, line 18:
``` dart
class JokeCard extends StatelessWidget {...}
```
joke_card.dart, line 56
```dart
class LikeButton extends StatefulWidget {...}
```

##### 1.1.6 Displaying one joke at a time
You can run and check

##### 1.1.7 The Only Like Button (because you can’t dislike Chuck Norris) — change of a joke
You can run and check

##### 1.1.8 Use json_serializable or freezed for Joke model
joke_card.dart, lines 17-18:
``` dart
@JsonSerializable()
class JokeModel {...};
```
##### 1.1.9 Avoid lint errors/warnings/infos (without ignore usage)
![No Lint Errors](/img/no_lint_errors.jpg "No Lint Errors")

##### 1.1.10 Keep your code formatted (will be checked via flutter format)
![Code is formatted](/img/code_formatted.jpg "Code Formatted")

### 2. Assigment 2
#### 2.1 Basic requirements
##### 2.1.1 Up-to-date readme with a short description and screenshot(s) of your application
You are reading it right now
##### 2.1.2 Application builds successfully for Android: working APK (or link to it) is attached to readme
Link to APK is in the end of Readme
##### 2.1.3 App is stable — no crashes or broken behaviour
You can run and check it
##### 2.1.4 Unhandled exceptions handling with Crashlytics
main_dart, lines 10-13, main function:
``` dart
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
```
##### 2.1.5 A separate screen Favourites — persisting favourite jokes
main_application.dart, lines 14-17, ChuckTinderApplication.build function:
```dart 
      routes: {
        '/': (BuildContext context) => const MainPage(),
        '/favourites': (BuildContext context) => const FavouritesPage()
      }
```
##### 2.1.6 App is organised according to some architecture pattern and some state-management approach is used. UI files  separated from logic files
updating_functions.md cares all netwowk and storage logic. Also, project uses BLoC architecture.

##### 2.1.7 flutter_lints rules are enabled and no errors/warnings/infos. You can use ignore only if it's reasonable and you can explain why you used it.
No ignores.
![No Lint Errors](/img/no_lint_errors.jpg "No Lint Errors")

##### 2.1.8 Missing network situation is handled
updaing_functions.dart, lines 35-42, updateJokeAccordingToCategory function:
``` sart
  } on SocketException catch (_) {
    return JokeCard(
        JokeModel.fromJson({
          "url": "",
          "id": missingNetworkJokeCardId,
          "value": "Sorry, something got wrong with network ;("
        }),
        false);
    }
```

#### 2.2 Advanced requirements
##### 2.1.6 Filtering jokes by category (api has category param)
main_page.dart, lines 12-17
``` dart
class CategoryCubit extends Cubit<Category> {
  CategoryCubit() : super(Category(categoryRequestParameters[0]));
  void changeCategory(Category newCategory) {
    emit(newCategory);
  }
}
```
This is a class to hold a category of joke
Data of this cubit is used in requests.
updating_functions.dart, lines 18-19, updateJokeAccordingToCategory functions:
``` dart
    url = Uri.http(
        apiDomain, domainPath, {"category": category.requestParameter});
```

### 3. Instructor requirements
##### 3.1 Satisfy all basic criterions from two assigments
Proff is above
##### 3.2 Additionaly use BLoC architecture to manage application state
Displayed joke and request category are stored in cubits from BLoC framework
main_page.dart, lines 12-25:
``` dart
class CategoryCubit extends Cubit<Category> {
  CategoryCubit() : super(Category(categoryRequestParameters[0]));
  void changeCategory(Category newCategory) {
    emit(newCategory);
  }
}

class JokeCardCubit extends Cubit<JokeCard?> {
  JokeCardCubit() : super(null);

  void refreshJokeCard(Category category) async {
    emit(await updateJokeAccordingToCategory(category));
  }
}
```
UI is redrawed with change of Cubit states
category_button.dart, lines 37-39, CategoryButtonState.build function:
``` dart
          BlocBuilder<CategoryCubit, Category>(
              builder: (context, Category state) {
            return Text(state.name);
```
joke_card_holder.dart, lines 16-29, JokeCardHolderState:
``` dart
  Widget build(BuildContext context) {
    return BlocBuilder<JokeCardCubit, JokeCard?>(builder: (context, state) {
      return Container(
          padding: const EdgeInsets.all(12),
          child: state != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state,
                  ],
                )
              : null);
    });
  }
```
##### 3.3. Set up the GitHub Actions to make linter, formatter and builder automatically run with push request
Set up for Actions is in .github/workflows/flutter_actions.yaml

## Link to APK
[app-release.apk](https://drive.google.com/file/d/1RFMI4cYFsDRuHD7d7cZD1RZgp5_tumln/view?usp=sharing)


