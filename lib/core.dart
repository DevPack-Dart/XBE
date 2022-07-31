class Oatcake extends IronEngine with{
  Oatcake(): super(true) {
    this.init();
  }
  void init(){
    super.init();
  }
}
class Notcher extends IronEngine with{
  Notcher(): super(true) {
    this.init();
  }
  void init(){
    super.init();
  }
}
class IronEngine extends BlueCore with{
  IronEngine([bool hasPerturbation = false]): super(hasPerturbation) {}
  void init(){
    super.init();
  }
}
class BlueCore{
  void Function() propagator;
  BlueCore([bool hasPerturbation = false]){
    if(!hasPerturbation){
      this.init();
    }
  }
  void init(){}
}
//requires dart:io
mixin FileSystemManager on BlueCore{
  late final Directory currentDir;
  late final Directory scriptDir;
  void init(){
    super.init();
  }
  String readFile(File file){}
  String joint(List<String> from)=>from.join("\n");
  String pathBuild<E extends FileSystem>(Directory base, List<String> cdSegments){
    for(int i = 0; i <= cdSegments; i++){
      base.cd(cdSegments[i]);
    }
  }
}
mixin CliTaskManager on BlueCore{
  void init(){
    super.init();
  }
  void shRun(){}
}
mixin PubWorkManager on BlueCore, CliTaskManager{
  void init(){
    super.init();
  }
  void packageCreate(){}
  void pubGet(){}
  void specConstruct(){}
}
//requires dart:io
mixin BeamsBuildManager on BlueCore, PubWorkManager, FileSystemManager{
  void init(){
    super.init();
  }
  void build({File? from, Directory? to}){
  }
  void rewrite(Map<BeamNode, BeamNode> rules){}
  void linker(List<BeamsRef> targets){
    String stdLib = this.readFile(this.pathBuild<File>(this.scriptDir, ["stdlib.dart"]));
    String stdLibHead = this.dartHead(stdLib);
    String stdLibBody = this.dartBody(stdLib);
    String heads = this.head
    List<String> sources = <String>[];
  }
}
mixin DartRuntimeManager on BlueCore, BeamsBuildManager{
  void init(){
    super.init();
  }
  Result<ApolloRunner, DartStateError> Function(String, [String]) runtime = (String source, [String? path]) async {
    ApolloVM apolo = ApolloVM();
    CodeUnit sourceUnit = CodeUnit("dart", source, path ?? "");
    bool res = await apolo.loadCodeUnit(sourceUnit);
    if(!res){
      return Result.err(StateError('Error parsing Dart code!'));
    }
    return Result.ok(ApolloRunnerDart(apolo));
    }
  R exec<R>() async {
    Result<ApolloRunner, DartStateError> res = await this.runtime()
  }
}
mixin BeamsAutoInterpretingManager on BlueCore, DartRuntimeManager{
  void init(){
    super.init();
  }
}
class BeamsRef{}
class BeamNode{}
class DartCode{
  List<String> langHead = <String>[];
  List<DartPkgHead> pkgHead = <DartPkgHead>[];
  Map<String, String> topElements = <String, String>{};
  factory DartCode(String src){}
  factory DartCode.fromFile(File file){
    if(!file.existsSync()){
      throw Error();
    }
    return DartCode(file.readAsStringSync());
  }
  factory DartCode.fromHTTP(Uri path){
    AsyncWaiter<T> cpl = AsyncWaiter<T>();
    
  }
  DartCode.direct();
}
class DartPkgHead{
  String name;
  Uri baseSrcPath;
  List<String> pathSegment;
  Uri fullSrcPath;
  late File file;
  bool isLocal;

}
class DartPubSpec{
  final String name;
  DartPubVersioning _version;
  Map<String, DartPubVersioning> _dependencies;
  Map<String, DartPubVersioning> _dependency_overrides;
  Map<String, DartPubVersioning> _dependency_specifies;
  DartPubSpec(this.name, this._version, this._dependency_specifies, this._dependency_overrides):
    this._dependencies = <String, DartPubVersioning>{} {
      this._dependencies.
    }
  DartPubVersioning get version = this._version;
  Map<String, DartPubVersioning> get dependencies = this._dependencies;
  Map<String, DartPubVersioning> get dependency_overrides = this._dependency_overrides;
  Map<String, DartPubVersioning> get dependency_specifies = this._dependency_specifies;
}
class DartPubVersioning extends SemanticVersioning{}
class SemanticVersioning extends Versioning{}
class CommonVersioning extends Versioning{}
abstract class Versioning{}
//Make Seamless among Sync and Async
//ToDo: How observe nesting of AsyncWaiter?
class AsyncWaiter<T> with AsyncWaitContext<T>{
  Future<T> Function(AsyncWaitContext<T>) fn;
  late T result;
  //@Contract.invariant<Object?>("{}", (Object? o)=>i ==null||o is Error||o is Exception)
  Object? error;
  StackTrace? stacktrace;
  factory AsyncWaiter.value(Future<T> val)=>AsyncWaiter((AsyncWaitContext _)=>val);
  AsyncWaiter(this.fn()){}
  void complete([Duration? timeout, Map<Symbol,Object> param = <Symbol,Object>{}]){
    Future.unawaited(fn(this.includes(param)));
  }
  T call([Duration? timeout]){}
}
mixin AsyncWaitContext<T>{
  late Map<Symbol,Object> param;
  AsyncWaitContext<T> includes(Map<Symbol,Object> param){
    this.param = param;
    return this;
  }
}