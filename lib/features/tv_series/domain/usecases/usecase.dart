abstract interface class UseCase<Return, Parameter> {
  Future<Return> call(Parameter parameter);
}
