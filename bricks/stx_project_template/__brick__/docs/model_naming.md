# Model naming

Naming rules for models in `packages/app_api` (wire types) and `lib/domain/models` (domain types).

## Wire types (`packages/app_api`)

Every model in `app_api` carries a wire suffix.

| Kind | Suffix | Examples |
|---|---|---|
| A resource as the backend represents it | `Dto` | `TaskDto`, `ChatDto` |
| An enum | `Dto` | `TaskStatusDto` |
| A payload the app sends | `Request` | `TaskCreateRequest`, `TaskUpdateRequest`, `TaskSearchRequest` |
| An endpoint result that isn't a resource | `Response` | `TokenResponse`, `CheckoutResponse`, `PageResponse<TaskDto>` |
| A socket or push payload | `Message` | `TaskUpdatedMessage` |

- The stem is singular and comes first: `TaskCreateRequest`, not `CreateTaskRequest` or `TasksCreateRequest`. Plural is for `TasksService`, `TasksRepository` and `TasksBloc`.
- The file name is the class name in snake case, under `lib/src/models/<feature>/`: `task_dto.dart`, `task_create_request.dart`.
- A `Dto` is named after the resource, not after an endpoint. The same `TaskDto` is returned by get, list, create and update, and stays `TaskDto` when it is also sent as a body.
- When list and details return different shapes, name them by shape: `TaskSummaryDto`, `TaskDetailsDto`.
- A `Dto` nests only `Dto`s.
- An id that goes into the URL is a method argument, not a field: `updateTask(int id, TaskUpdateRequest request)`.
- One or two primitives need no model: `assignTask(int id, int userId)`.
- An enum is used in both directions; there is no `Request` variant.
- An enum keeps its wire value in a `value` field and is annotated with `@JsonEnum(valueField: 'value')`.
- An enum has an `unknown` value, and each field of that type sets `@JsonKey(unknownEnumValue: TaskStatusDto.unknown)`.

```dart
@JsonEnum(valueField: 'value')
enum TaskStatusDto(final String value) {
  todo('todo'),
  inProgress('in_progress'),
  done('done'),
  unknown('unknown'),
}
```

## Domain types (`lib/domain/models`)

A domain type has the name of its wire type with the suffix removed or swapped.

| Wire | Domain |
|---|---|
| `TaskDto` | `Task` |
| `TaskStatusDto` | `TaskStatus` |
| `TaskCreateRequest` | `TaskCreateParams` |
| `CheckoutResponse` | `CheckoutResult` |
| `PageResponse<TaskDto>` | `Page<Task>` |

A domain type is one of two things:

- **Alias**, when it has the same shape as the wire type. It is a typedef in `lib/domain/models/index.dart`.
- **Class**, when the shape differs. It has its own file under `lib/domain/models/<feature>/`, is exported from the index, and has a mapper in `lib/data/mappers/`.

```dart
// lib/domain/models/index.dart
import 'package:app_api/models.dart';

export 'package:app_api/models.dart' show AuthStatus;

export 'general_models.dart';
export 'task/task.dart';
export 'user/user_data.dart';

typedef Chat = ChatDto;
typedef UserProfile = UserProfileDto;
typedef TaskStatus = TaskStatusDto;
typedef TaskCreateParams = TaskCreateRequest;
```

- An alias is the same type as its wire type: `toString()` and analyzer messages show the wire name.
- A wire type nobody outside `lib/data` needs has no domain name: `TokenResponse`, `ErrorResponse`.
- A type that exists only in the app is unsuffixed and lives in `lib/domain/models/`: `UserData`.
- A type that doesn't come from `app_api` keeps its name and is re-exported with `show`: `AuthStatus` from `api_client`.
- Labels, colours and icons for an enum go into a presentation extension on the domain name. They are not a reason to turn an alias into a class.

## Mappers (`lib/data/mappers`)

- One file per feature: `task_mapper.dart`.
- One extension per source type, named `<Source>Mapper`.
- `toDomain()` on a `Dto` or `Response`, `toDto()` on a domain class that is sent back, `toRequest()` on `Params`.
- Only repositories call mappers.
- An alias has no mapper: the repository passes the value straight through.
- When one form serves create and update, use a single `TaskFormParams` with `toCreateRequest()` and `toUpdateRequest()`.

```dart
// lib/data/mappers/task_mapper.dart
extension TaskDtoMapper on TaskDto {
  Task toDomain() => Task(id: id, name: title);
}

extension TaskCreateParamsMapper on TaskCreateParams {
  TaskCreateRequest toRequest() => TaskCreateRequest(title: name);
}
```

```dart
// lib/data/repositories/tasks_repository.dart
Future<Task> createTask(TaskCreateParams params) async =>
    (await _tasksService.createTask(params.toRequest())).toDomain();
```

## Where each type may appear

| Layer | Types |
|---|---|
| `app_api` services | Wire types only |
| `lib/data` repositories | Domain types in signatures, wire types inside |
| `lib/presentation` | Domain types only |

- No type name ending in `Dto`, `Request`, `Response` or `Message` appears in `lib/presentation`.
- `lib/presentation` imports models from `lib/domain/models/index.dart`, never from `package:app_api`.

## Turning an alias into a class

1. Remove the typedef from `lib/domain/models/index.dart`.
2. Add the class in `lib/domain/models/<feature>/<model>.dart` and export it from the index.
3. Add the mapper to `lib/data/mappers/<feature>_mapper.dart`.
4. Fix the repository methods the compiler flags.
5. Do the same for every alias whose wire type nests this one: `Task` can't stay an alias of a `TaskDto` that contains `TaskStatusDto` once `TaskStatus` is a class.

`app_api` and `lib/presentation` don't change.
