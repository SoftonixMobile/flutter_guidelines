
# Documentation
**Rules that should be followed to write code according to guidelines** 
\
The Softonix team considers these rules necessary to maintain a single style of code, avoid chaos when writing code, and ensure that the code's organization is the same for all projects.

### Table of contents:
 [Project Structure](#project-structure):
 - [Screens](#screens)
    - [Structure inside any screen folder](#structure-inside-any-screen-folder)
    - [Authentication Manager for app ](#authentication-manager-for-app)
       - [Auth Flow ](#auth-flow) 
       - [Home](#home) 
    - [Screen with Tab Navigation ](#screen-with-tab-navigation)
    - [Screen with Form Pages ](#screen-with-form-pages)
-  [Repositories](#repositories)

[Naming](#naming):
 - [Screens naming](#screens-naming)
-  [Repositories naming](#repositories-naming)

[Best practices](#best-practices):
 - [Imports Styles](#imports-styles )
    - [Sort Imports](#sort-imports)
    - [Creating indexes](#creating-indexes)
    - [Use full or relative import path](#use-full-or-relative-import-path)
 - [Screens best practices](#screens-best-practices)
 - [Repositories best practices](#repositories-best-practices)
    - [Methods sorting](#methods-sorting)
 - [Widgets](#widgets)
   - [Attributes in widgets](#attributes-in-widgets)
   - [Callbacks location](#callbacks-location)
   - [Required attributes location](#required-attributes-location )
   - [Attributes sorting](#attributes-sorting)
   - [Using the default attribute param](#using-the-default-attribute-param )
   - [Constructing instances](#constructing-instances)
 - [BLoC style](#bloc-style)
    - [Attributes in BLoC](#attributes-in-bloc)
    - [Write event-handler method for each event](#write-event-handler-method-for-each-event)
    - [Using typedef for State Annotation](#using-typedef-for-state-annotation)
    - [Naming for repository instance](#naming-for-repository-instance)
 -  [Data Classes](#data-classes)
    - [Attributes in data-classes](#attributes-in-data-classes)
    - [Creating models with Freezed](#creating-models-with-freezed)

  
## Project Structure
Here is the structure for the project

### Screens
In your main program folder, `lib`, there should be a folder called `screens`, and all screen-specific folders should be located within it. The arrangement of items inside each screen's folder may vary depending on the use case.

#### Structure inside any screen folder
Simply has the file of the widget, which represents a route placed directly inside the screen folder. May have a widgets folder if you have specific widgets only for this screen. Also, we could have a bloc that manages states for this screen. 

- `{name}`
    - `{name}_screen.dart` - This file represents the main widget for the route.
    - `widgets` - Widgets created specifically for this screen are placed here.
    - `{name}_bloc.dart` - Bloc created specifically for this screen are placed here.

####  Authentication Manager for app 
Structure for screens responsible for managing the user authentication flow. The main folder `screens` should typically display the following structure:

`screens` 
- [`auth_flow`](#auth-flow): here placed all screens related to the user authorization flow
  - `signIn`
  - `signUp`
  - `forgotPassword`

- [`home`](#home): here placed the main screen of the app (typically a screen with tabs)
   - `dashboard`
   - `profile`
   - `settings`
   - `home_screen.dart`

- `authentication_manager_screen.dart`: the screen of the wrapper application that determines which screen the user will see based on the authorization status


####  Auth Flow
The authorization flow folder will contain folders for screens that represent the authorization flow (such as signIn, signUp, or forgot password). That is all screens that will precede the home screen.

- `sign_in`
  - `sign_in_form_screen.dart`
  - `sign_in_form_bloc.dart`

- `sign_up`
  - `sign_up_form_screen.dart`
  - `sign_up_form_bloc.dart`

- `forgot_password`
  - `forgot_password_form_screen.dart`
  - `forgot_password_form_bloc.dart`


####  Home
The home folder represents the entry point and all screens that the user sees after successful authorization.
**Example:**
- `other screens` 
- `home_screen.dart` - basically a screen with a bottom navigation bar
- `home_wrapper.dart`- file which wrap `home_screen` `by home_state_wrapper`
- `home_state_wrapper.dart` -  file where wrapper all home screen is located, basically BlocProvider with necessary blocs.

####  Screen with Tab Navigation

Suppose our screen contains inner navigation using tabs (e.g., tab bar, bottom navigation bar, page view, etc.). In that case, we should separate each tab into folders simply within the Tabbed Screen folder to encapsulate them.

**Example:**

`example` - screen's folder 
-  `example_screen.dart` - screen with tab's navigation
-  `first_tab` - folder for the first tab 
-  `second_tab` - folder for the second tab 
    - `second_tab_screen.dart`

####  Screen with Form Pages

A screen may have associated form pages, such as a chat list (main screen) and a chat details page where you can typically edit fields (form screen). To organize this structure, create a folder named `{name}` for the main screen. Inside, create a `pages` folder where form screens are placed. It works with all cases when you have screens that can open only from the main screen.

**Example:**

- `{name}`
   - `{name}_screen.dart`
    - `pages`
      - `{name1}` - create a separate folder if the page has connected bloc or other files.
              - `{name1}_form_screen.dart`
              - `{name1}_form_bloc.dart`
              - `{name}details_screen.dart`

### Repositories
Basically, all repositories have to be in a folder inside `lib` named `repositories`. Otherwise, if you are sure that it's used only in one bloc on one screen, you can place the repository in the screen folder next to the screen bloc.

 Structure inside repositories folder:
- `auth_repository.dart`
- `user_repository.dart`
- `index.dart`
- ...

Repository placed inside screen folder structure :
- `example_screen.dart`
- `example_repository.dart`
- `example_bloc.dart`

## Naming
General rules for naming elements across app

### Screens naming
Screens should be named correctly based on what screen is present or for what is used. It's unnecessary to add the ending  "screen" to the screen's folder name. Only .dart file with the main widget for the route should have this ending. 

Screens inside the pages folder, which have connected FormBloc, should be named `{name}_form_screen.dart`.

### Repositories naming
Name the file and the repository class the same, either according to the entity you're getting or a common name for what we're using it for. End with **repository**. 
For example:
A repository that contains methods for working with the Employee entity should be named EmployeeRepository.
The repository that contains methods for logging in and out of the system is logically named AuthRepository.

> Structure example: 
> File name  - `{name}_repository.dart`
> Class name  - `{Name}Repository`

### Widgets naming

## Best practices

### Imports Styles 
#### Sort Imports
   It's a GOOD practice to sort imports for several reasons: ***Readability and Consistency, Avoiding Conflicts, Easier Maintenance, Helpful for Version Control***

   **Usage** - Sort import after each PR using:
`dart run import_sorter:main`

#### BAD:
  ```dart
    import 'package:flutter/material.dart';
    import 'package:some_package/some_module.dart';
    import 'package:another_package/another_module.dart';
    import 'package:flutter/scheduler.dart';
    import 'package:flutter/services.dart';
    import 'dart:convert';
  ```
#### GOOD:
 ```dart
    import 'dart:convert';

    import 'package:flutter/material.dart';
    import 'package:flutter/services.dart';
    import 'package:flutter/scheduler.dart';

    import 'package:another_package/another_module.dart';
    import 'package:some_package/some_module.dart';
  ```


#### Creating indexes
Creating indexes for imports enhances code organization, improves maintainability, reduces redundancy

 **Usage** - Create the *index.dart* file where the necessary files will be exported. Use this file to reduce the import amount.

 Example of index.dart
 ```dart
    export 'opacity_card.dart';
    export 'custom_section.dart';
    export 'slidable_action.dart';
```

 #### BAD:
  ```dart
    import 'package:flutter/material.dart';

    import 'widgets/opacity_card.dart';
    import 'widgets/custom_section.dart';
    import 'widgets/slidable_action.dart';

    //Some other imports

  ```

  #### GOOD:
   ```dart
    import 'package:flutter/material.dart';

    import 'widgets/index.dart';
    // Some other imports
    
  ```



####  Use full or relative import path  
Including the full import path makes it clear and explicit where the imported module or component is coming from. It leaves no ambiguity about the source of the imported functionality.

In a larger project, there might be modules or components with similar names in different packages. Using the full import path helps avoid potential naming conflicts or ambiguities by specifying the exact source of the import.

>***Exception:*** If an import is from locale/current folder (e.g.,/blocs/necessary_file.dart, /widgets/necessary_file.dart), use relative import (see example №2)

 #### Example 1
    
   ---
**BAD:**
  ```dart
    import '../../../extensions.dart';
  ```

**GOOD:**
 ```dart
    import 'package:project/widgets/helpers/extensions.dart';
```
  $~$
 #### Example 2
  ---
**BAD:**
  ```dart
    import 'package:project/screens/current_screen/repository.dart';
    import 'package:project/screens/current_screen/widgets/custom_widgets.dart';
    import 'package:project/screens/current_screen/bloc/current_screen_bloc.dart';
  ```

**GOOD:**
  ```dart
    import '../repository.dart';
    import 'widgets/index.dart';
    import 'bloc/current_screen_bloc.dart';
  ```
  ---
### Screens best practices
In your Flutter project, screens are essentially routes. In Android, a route is equivalent to an Activity, and in iOS, it's equivalent to a ViewController. In Flutter, a route is represented as a widget. Therefore, if you have routes to navigate, you must have widgets to display those routes.
To write a good screen, follow the general rules for writing widgets. 

---
### Repositories best practices
The Repository Pattern is based on the idea that data access code should be separated from business logic code. The Repository Pattern provides a way to manage data access code in a centralized location, thus reducing code duplication and improving code maintainability.
#### Methods sorting
If you use a repository to perform CRUD operations, the methods should be ordered accordingly [Read, Create, Update, Delete ].
If the repository works with multiple entities, the methods need to be sorted by each of them.
To illustrate, we have an instance of Posts, and for it, we need Comments, which are received through a different endpoint than Posts (in this case, you can use both in the same repository). So, the methods inside the repository should be sorted by entity, and the Post method should come first as the main entity.

> **Recommendation:**
> Use unnamed parameters in the repository constructor (it would simplify code). If your repository uses one endpoint with different methods (POST, PUSH, PUT, etc.), you better create a getter for the endpoint URL and use a variable in all methods to not mess up

 **GOOD:**
```dart
class EntityRepository {
  final HttpClient httpClient;

  EntityRepository(this.httpClient);
  
  // getter for use in multiple places
  String get endpointUrl => '/entity';
   
  // Read
  Future<Entity> getEntity() async {
    final response = await httpClient.get(endpointUrl);

    return Entity.fromJson(response.data);
  }
  
  Future<Entity> getEntityById(int id) async {
    final response = await httpClient.get('$endpointUrl/$id');
    
    return Entity.fromJson(response.data);
  }
  
  // Create
  Future<Entity> createEntity(Entity payload) async {
    final response = await httpClient.post(endpointUrl, data: payload.toJson());

    return Entity.fromJson(response.data);
  }

  // Update
  Future<Entity> updateEntity(Entity payload) async {
    final response = await httpClient.put(endpointUrl, data: payload.toJson());

    return Entity.fromJson(response.data);
  }

  // Delete
  Future<bool> deleteEntity(int id) async {
    final response = await httpClient.delete('$endpointUrl/$id');

    return response.data as bool;
  }
}
```
---
### Widgets
  
####  Attributes in widgets
 Attributes in widget classes should be placed ***AFTER*** constructor.  
  
 It is a common practice borrowed from Flutter docs  
  
**BAD:** 
 ```dart  
    class ExampleWidget extends StatelessWidget {  
        final String title;  
        final TextStyle style;  
        final VoidCallback? onTap;  
  
        const ExampleWidget({  
            super.key,  
            required this.title,  
            required this.style,  
            this.onTap,  
        });  
  
        @override  
        Widget build(...)  
    }  
  ```  
**GOOD:**  
 ```dart  
    class ExampleWidget extends StatelessWidget {  
        const ExampleWidget({  
            super.key,  
            required this.title,  
            required this.style,  
            this.onTap,  
        });  
  
        final String title;  
        final TextStyle style;  
        final VoidCallback? onTap;  
  
        @override  
        Widget build(...)  
    }  
```  
#### Callbacks location   
 Callbacks should be placed ***IN THE END*** of attributes annotation and be ***separated*** with blank space.  
  
  
**BAD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            required this.onTap,  
            required this.decoration,  
            required this.itemBuilder,  
        });  
  
        final String title;  
        final VoidCallback onTap;  
        final BoxDecoration decoration;  
        final void Function(BuildContext, int) itemBuilder;  
  
        @override  
        Widget build(...)  
    }  
```  
**GOOD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            required this.decoration,  
            required this.onTap,  
            required this.itemBuilder,  
        });  
  
        final String title;  
        final BoxDecoration decoration;  
  
        final VoidCallback onTap;  
        final void Function(BuildContext, int) itemBuilder;  
  
        @override  
        Widget build(...)  
    }  
```  
#### Required attributes location   
 Required attributes should be placed at the beginning of the constructor.  
  
**BAD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            this.caption,  
            required this.title,  
            required this.someLongField,  
        });  
  
        final String title;  
        final String? caption;  
        final String someLongField;  
  
        @override  
        Widget build(...)  
    }  
```  
**GOOD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            required this.someLongField,  
            this.caption,  
        });  
  
        final String title;  
        final String? caption;  
        final String someLongField;  
  
        @override  
        Widget build(...)  
    }  
```  
#### Attributes sorting  
 Attributes should be sorted according to the importance of their value and relativity and must be separated. Field can be sorted inside constructor different(see example 1 [someLongField])  
  
 This is a relative rule and has no strict limitations.  
    
 Usage with the optional field is shown in example №2  
  
**Example 1**  
 ---  
**BAD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            required this.caption,  
            this.child,  
            required this.titleStyle,  
            required this.captionBgColor,  
            required this.onChange,  
            required this.someLongName,  
        });  
  
        final String title;  
        final String caption;  
        final Widget? child;  
        final TextStyle titleStyle;  
        final Color captionBgColor;  
        final void Function(String, int) onChange;  
        final void Function() someLongName;  
        final TextStyle captionStyle;  
  
        @override  
        Widget build(...)  
    }  
```  
**GOOD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            required this.titleStyle,  
            required this.caption,  
            required this.captionStyle,  
            required this.captionBgColor,  
            required this.onChange,  
            required this.someLongName,  
            this.child,  
        });  
  
        final String title;  
        final TextStyle titleStyle;  
  
        final String caption;  
        final Color captionBgColor;  
        final TextStyle captionStyle;  
  
        final void Function() someLongName;  
        final void Function(String, int) onChange;  
  
        final Widget? child;  
  
        @override  
        Widget build(...)  
    }  
```  
  $~$  
**Example 2**  
 ---  
**BAD:**  
 ```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            this.titleStyle,  
            required this.caption,  
            this.captionStyle,  
            this.captionBgColor,  
            this.someLongName,  
            required this.onChange  
            this.child,  
        });  
  
        final String title;  
        final TextStyle? titleStyle;  
  
        final String caption;  
        final Color? captionBgColor;  
        final TextStyle? captionStyle;  
  
        final void Function()? someLongName;  
        final void Function(String, int) onChange;  
  
        final Widget? child;  
  
        @override  
        Widget build(...)  
    }  
```  
**GOOD:**  
 ```dart  
    class Example extends StatelessWidget {  
         const Example({  
            super.key,  
            required this.title,  
            required this.caption,  
            required this.onChange  
            this.titleStyle,  
            this.captionStyle,  
            this.captionBgColor,  
            this.someLongName,  
            this.child,  
        });  
  
        final String title;  
        final TextStyle? titleStyle;  
  
        final String caption;  
        final Color? captionBgColor;  
        final TextStyle? captionStyle;  
  
        final void Function()? someLongName;  
        final void Function(String, int) onChange;  
  
        final Widget? child;  
  
        @override  
        Widget build(...)  
    }  
```  
#### Using the default attribute param    
 If the value null does not affect the logic, it is worth writing the default value and omitting "?" in type.  
  
**BAD:**  
```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            this.caption,  
        });  
  
        final String title;  
        final String? caption;  
  
        @override  
        Widget build(...){  
            return Text(caption ?? '');  
        }  
    }  
```  
**GOOD:**  
```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.title,  
            this.caption = '',  
        });  
  
        final String title;  
        final String caption;  
  
        @override  
        Widget build(...){  
            return Text(caption);  
        }  
    }  
  ```  
  
####  Constructing instances     
The parameters passed to the constructor must be sorted according to their importance and length.  
  
**Explanation to example:** someReallyLongButNecessaryField must be first due to its importance, and the location of the other two fields (dates, caption) is not so important, so we can locate them according to genal line length  
    
 Widget class  
```dart  
    class Example extends StatelessWidget {  
        const Example({  
            super.key,  
            required this.someReallyLongButNecessaryField,  
            required this.title,  
            required this.caption,  
        });  
  
        final String someReallyLongButNecessaryField;  
  
        final List<DateTime> dates;  
        final String caption;  
  
        @override  
        Widget build(...){  
            return Text(caption ?? '');  
        }  
    }  
  ```  
 ---  
**BAD:** 
```dart  
    ...  
    final User user;  
  
    Widget build(BuildContext context){  
        final userApprovedTimeOffDays = // Some logic  
  
        return Row(  
            children: [  
                ...  
                Example(  
                    dates: userApprovedTimeOffDays,  
                    someReallyLongButNecessaryFiled: user.id,  
                    caption: user.name,  
                )  
            ]  
        )  
    }  
  ```
  
**GOOD:**  
```dart  
     ...  
    final User user;  
  
    Widget build(BuildContext context){  
        final userApprovedTimeOffDays = // Some logic  
  
        return Row(  
            children: [  
                ...  
                Example(  
                    someReallyLongButNecessaryFiled: user.id,  
                    caption: user.name,  
                    dates: userApprovedTimeOffDays,  
                )  
            ]  
        )  
    }  
  
```
---  
### BLoC style  

#### Attributes in BLoC   
 Attributes should be located **before** the constructor(the same logic as data-class attributes). They should be sorted according to their importance.  
  
 When using the 'get_it' attributes with ```@factoryParams``` should be placed in the first place (see example 2)  
  
**Example 1**  
 ---  
**BAD:**    
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        ExampleBloc({  
            this.initial;  
            required this.userData,  
            required this.settings,  
            required this.repository,  
        });  
  
  
        final ExampleModel? initial;  
  
        final UserData userData;  
        final UserRepository repository;  
        final List<UserSettings> settings;  
        ...  
    }  
   ```  
**GOOD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        final ExampleModel? initial;  
  
        final UserData userData;  
        final UserRepository userRepository;  
        final List<UserSettings> settings;  
  
        ExampleBloc({  
            required this.initial;  
            required this.userData,  
            required this.settings,  
            required this.userRepository,  
        });  
        ...  
    }  
```  
  $~$  
**Example 2**  
 ---  
**BAD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        final UserData userData;  
        final ExampleModel? initial;  
        final UserRepository repository;  
  
        ExampleBloc({  
            required this.userData,  
            required this.repository,  
            this.initial,  
        });  
        ...  
    }  
  ```  
 **GOOD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        final ExampleModel? initial;  
  
        final UserData userData;  
        final UserRepository userRepository;  
  
        ExampleBloc({  
            @factoryParam this.initial;  
            required this.userData,  
            required this.userRepository,  
        });  
        ...  
    }  
  ```  
  ---
#### Write the event-handler method for each event   
 The logic for handling events must be separated inside different methods instead of writing everything inside the constructor.  
  
 This approach increases readability and code maintenance.   
  
 The method must be named like this:  
  ***Omit the word 'Event' when naming the method***  
 ```dart  
    FutureOr<void> _eventName(  
        _EventName$Event event,  
        Emitter<ExampleState> emit,  
    ) async {  
      // Logic there  
    }  
```  
**BAD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        ExampleBloc({  
           // attributes  
        }){  
            on<_LoadEvent>((event, emit){  
                // Some logic  
            });  
            on<_DeleteEvent>((event, emit){  
                // Some logic  
            });  
        };  
  
        ...  
    }  
```  
**GOOD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        ExampleBloc({  
           // attributes  
        }){  
            on<_LoadEvent>(_load);  
            on<_DeleteEvent>(_delete);  
        };  
  
        FutureOr<void> _load(  
            _LoadEvent event,  
            Emitter<ExampleState> emit,  
        ){  
         // Logic there  
        }  
  
        FutureOr<void> _delete(  
            _DeleteEvent event,  
            Emitter<ExampleState> emit  
        ){  
            // Logic there  
        }  
        ...  
    }  
```  
---
#### Using typedef for State Annotation
 In the process of writing BLoC using stx_bloc_base sometimes states can be very long. Use ```typedef``` to shorten the state name and make it more understandable.  
  
**BAD:**  
 ```dart  
    class ExampleBloc extends NetworkFilterableListBloc<  
        SomeLongModelName,  
        VeryLongNameForFilterModel,  
        NetworkFilterableListState<SomeLongModelName, VeryLongNameForFilterModel>  
        >{  
  
        ...  
    }  
   ```  
**GOOD:**  
 ```dart  
    typedef ExampleState = NetworkFilterableListState<SomeLongModelName, VeryLongNameForFilterModel>;  
  
    class ExampleBloc extends NetworkFilterableListBloc<  
        SomeLongModelName,  
        VeryLongNameForFilterModel,  
        ExampleState,  
        >{  
  
        ...  
    }  
   ```  
   ---
#### Naming for repository instance 
 Always name repository instances according to the class name, even if there is only one repository used in the BLoC.  
  
**Example 1**  
 
**BAD:**  
 ```dart  
    class ExampleBloc extends NetworkBloc<..., ...>{  
        final int id;  
        final UserRepository repository;  
  
        ExampleBloc({  
            required this.id,  
            required this.repository,  
        });  
  
        ...  
    }  
```  
**GOOD:**  
 ```dart  
     class ExampleBloc extends NetworkBloc<..., ...>{  
        final int id;  
        final UserRepository userRepository;  
  
        ExampleBloc({  
            required this.id,  
            required this.userRepository,  
        });  
  
        ...  
    }  
  ```  
  $~$  
 **Example 2**  
 ---  
**BAD:**  
 ```dart  
    class ExampleBloc extends Bloc<..., ...>{  
        final int id;  

        final UserRepository repository;  
        final DashboardRepository dashboard;  
        final SettingsRepository settingsRepository;  
  
        ExampleBloc({  
            required this.id,  
            required this.repository,  
            required this.dashboard,  
            required this.settingsRepository,  
        });  
  
        ...  
    }  
   ```  
**GOOD:**  
 ```dart  
     class ExampleBloc extends Bloc<..., ...>{  
        final int id;  

        final UserRepository userRepository;  
        final SettingsRepository settingsRepository;  
        final DashboardRepository dashboardRepository;  
  
        ExampleBloc({  
            required this.id,  
            required this.userRepository,  
            required this.settingsRepository,  
            required this.dashboardRepository,  
        });  
          
        ...  
    }  
```
### Data Classes
####  Attributes in data-classes 
Attributes in data or BLoC classes should be placed ***BEFORE*** constructor.

 By placing attributes ***at the top*** of the data-class definition, you can easily see and manage the data members of the class. This can help you keep track of the state of the object and maintain code organization.

   
    
**BAD:**
```dart
    class Model {
        Model({
            required this.id,
            required this.title,
            required this.description,
        });

        final int id;
        final String title;
        final String description;
    }
```

**GOOD:**
```dart
    class Model {
        final int id;
        final String title;
        final String description;

        Model({
            required this.id,
            required this.title,
            required this.description,
        });
    }
```
#### Creating models with Freezed 
    - Instead of the keyword 'required', user '@Default(defaultValue)'. 
    - Use '@Default(defaultValue)' for optional parameters, in case logic for default value behaves the same as null-value.
    - Use @JsonKey(unknownEnumValue: CustomEnum.myValue) or @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) for enums

This is useful for creating default values payloads and omitting the use of redundant null-safety as well as handling production error when BE has breaking changes

    
**BAD:**
  ```dart
    @freezed
    class ExampleModel with _$ExampleModel {
        const factory ExampleModel({
            required int id,
            required String name,
            bool? isCompleted,
            int? assignedTo,
            @Default(ExampleType.model) ExampleType type
        }) = _ExampleModel;

        factory ExampleModel.fromJson(Map<String, dynamic> json) =>
            _$ExampleModelFromJson(json);
    }
 ```

**GOOD:**
   ```dart
    @freezed
    class ExampleModel with _$ExampleModel {
        const factory ExampleModel({
            @Default(0) int id,
            @Default('') String name,
            @Default(false) bool isCompleted,
            int? assignedTo,
            @JsonKey(unknownEnumValue: ExampleType.model)
            @Default(ExampleType.model) ExampleType type
        }) = _ExampleModel;

        factory ExampleModel.fromJson(Map<String, dynamic> json) =>
            _$ExampleModelFromJson(json);
    }
   ```





