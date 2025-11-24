      ] file or directory
'/Users/bintang/software/flutter/packages/flutter_tools/gradle/src/main/java', not
found
[  +88 ms] FAILURE: Build failed with an exception.
[        ] * Where:
[        ] Settings file
'/Users/bintang/development/training/flutter_buku_bisnis_app/android/settings.gradl
e.kts' line: 19
[        ] * What went wrong:
[        ] Error resolving plugin [id: 'dev.flutter.flutter-plugin-loader']
[        ] > A problem occurred configuring project ':gradle'.
[        ]    > Could not read workspace metadata from
/Users/bintang/.gradle/caches/8.12/kotlin-dsl/accessors/66a4afc4ecce242057c438fda13
8d2fe/metadata.bin
[        ] * Try:
[        ] > Run with --debug option to get more log output.
[        ] > Run with --scan to get full insights.
[        ] > Get more help at https://help.gradle.org.
[        ] * Exception is:
[        ] org.gradle.api.GradleException: Error resolving plugin [id:
'dev.flutter.flutter-plugin-loader']
[        ]      at
org.gradle.plugin.use.internal.DefaultPluginRequestApplicator.resolvePluginReques
t(DefaultPluginRequestApplicator.java:193)
[        ]      at
org.gradle.plugin.use.internal.DefaultPluginRequestApplicator.applyPlugins(Defaul
tPluginRequestApplicator.java:101)
[        ]      at
org.gradle.kotlin.dsl.provider.PluginRequestsHandler.handle(PluginRequestsHandler
.kt:42)
[        ]      at
org.gradle.kotlin.dsl.provider.StandardKotlinScriptEvaluator$InterpreterHost.appl
yPluginsTo(KotlinScriptEvaluator.kt:239)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter$ProgramHost.applyPluginsTo(Interprete
r.kt:387)
[        ]      at Program.execute(Unknown Source)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter$ProgramHost.eval(Interpreter.kt:516)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter.eval(Interpreter.kt:194)
[        ]      at
org.gradle.kotlin.dsl.provider.StandardKotlinScriptEvaluator.evaluate(KotlinScrip
tEvaluator.kt:130)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPluginFactory$create$1.invoke(KotlinSc
riptPluginFactory.kt:62)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPluginFactory$create$1.invoke(KotlinSc
riptPluginFactory.kt:48)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPlugin.apply(KotlinScriptPlugin.kt:35)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin$1.run(BuildOperationScriptPlu
gin.java:68)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:29)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:26)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.run(DefaultBuildOperat
ionRunner.java:47)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin.lambda$apply$0(BuildOperation
ScriptPlugin.java:65)
[        ]      at
org.gradle.internal.code.DefaultUserCodeApplicationContext.apply(DefaultUserCodeA
pplicationContext.java:44)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin.apply(BuildOperationScriptPlu
gin.java:65)
[        ]      at
org.gradle.initialization.ScriptEvaluatingSettingsProcessor.applySettingsScript(S
criptEvaluatingSettingsProcessor.java:75)
[        ]      at
org.gradle.initialization.ScriptEvaluatingSettingsProcessor.process(ScriptEvaluat
ingSettingsProcessor.java:68)
[        ]      at
org.gradle.initialization.SettingsEvaluatedCallbackFiringSettingsProcessor.proces
s(SettingsEvaluatedCallbackFiringSettingsProcessor.java:34)
[        ]      at
org.gradle.initialization.RootBuildCacheControllerSettingsProcessor.process(RootB
uildCacheControllerSettingsProcessor.java:47)
[        ]      at
org.gradle.initialization.BuildOperationSettingsProcessor$2.call(BuildOperationSe
ttingsProcessor.java:49)
[        ]      at
org.gradle.initialization.BuildOperationSettingsProcessor$2.call(BuildOperationSe
ttingsProcessor.java:46)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$CallableBuildOperation
Worker.execute(DefaultBuildOperationRunner.java:209)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$CallableBuildOperation
Worker.execute(DefaultBuildOperationRunner.java:204)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.call(DefaultBuildOpera
tionRunner.java:53)
[        ]      at
org.gradle.initialization.BuildOperationSettingsProcessor.process(BuildOperationS
ettingsProcessor.java:46)
[        ]      at
org.gradle.initialization.DefaultSettingsLoader.findSettingsAndLoadIfAppropriate(
DefaultSettingsLoader.java:183)
[        ]      at
org.gradle.initialization.DefaultSettingsLoader.findAndLoadSettings(DefaultSettin
gsLoader.java:86)
[        ]      at
org.gradle.initialization.SettingsAttachingSettingsLoader.findAndLoadSettings(Set
tingsAttachingSettingsLoader.java:33)
[        ]      at
org.gradle.internal.composite.CommandLineIncludedBuildSettingsLoader.findAndLoadS
ettings(CommandLineIncludedBuildSettingsLoader.java:35)
[        ]      at
org.gradle.internal.composite.ChildBuildRegisteringSettingsLoader.findAndLoadSett
ings(ChildBuildRegisteringSettingsLoader.java:44)
[        ]      at
org.gradle.internal.composite.CompositeBuildSettingsLoader.findAndLoadSettings(Co
mpositeBuildSettingsLoader.java:35)
[        ]      at
org.gradle.initialization.InitScriptHandlingSettingsLoader.findAndLoadSettings(In
itScriptHandlingSettingsLoader.java:33)
[        ]      at
org.gradle.api.internal.initialization.CacheConfigurationsHandlingSettingsLoader.
findAndLoadSettings(CacheConfigurationsHandlingSettingsLoader.java:36)
[        ]      at
org.gradle.initialization.GradlePropertiesHandlingSettingsLoader.findAndLoadSetti
ngs(GradlePropertiesHandlingSettingsLoader.java:38)
[        ]      at
org.gradle.initialization.DefaultSettingsPreparer.prepareSettings(DefaultSettings
Preparer.java:31)
[        ]      at
org.gradle.initialization.BuildOperationFiringSettingsPreparer$LoadBuild.doLoadBu
ild(BuildOperationFiringSettingsPreparer.java:71)
[        ]      at
org.gradle.initialization.BuildOperationFiringSettingsPreparer$LoadBuild.run(Buil
dOperationFiringSettingsPreparer.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:29)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:26)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.run(DefaultBuildOperat
ionRunner.java:47)
[        ]      at
org.gradle.initialization.BuildOperationFiringSettingsPreparer.prepareSettings(Bu
ildOperationFiringSettingsPreparer.java:54)
[        ]      at
org.gradle.initialization.VintageBuildModelController.lambda$prepareSettings$1(Vi
ntageBuildModelController.java:80)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$doTransition$14(StateT
ransitionController.java:255)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:266)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:254)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$transitionIfNotPreviou
sly$11(StateTransitionController.java:213)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:36
)
[        ]      at
org.gradle.internal.model.StateTransitionController.transitionIfNotPreviously(Sta
teTransitionController.java:209)
[        ]      at
org.gradle.initialization.VintageBuildModelController.prepareSettings(VintageBuil
dModelController.java:80)
[        ]      at
org.gradle.initialization.VintageBuildModelController.prepareToScheduleTasks(Vint
ageBuildModelController.java:70)
[        ]      at
org.gradle.internal.build.DefaultBuildLifecycleController.lambda$prepareToSchedul
eTasks$6(DefaultBuildLifecycleController.java:175)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$doTransition$14(StateT
ransitionController.java:255)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:266)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:254)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$maybeTransition$9(Stat
eTransitionController.java:190)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:36
)
[        ]      at
org.gradle.internal.model.StateTransitionController.maybeTransition(StateTransiti
onController.java:186)
[        ]      at
org.gradle.internal.build.DefaultBuildLifecycleController.prepareToScheduleTasks(
DefaultBuildLifecycleController.java:173)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeWorkPreparer.scheduleRequestedTasks
(DefaultBuildTreeWorkPreparer.java:36)
[        ]      at
org.gradle.internal.cc.impl.VintageBuildTreeWorkController$scheduleAndRunRequeste
dTasks$1.apply(VintageBuildTreeWorkController.kt:36)
[        ]      at
org.gradle.internal.cc.impl.VintageBuildTreeWorkController$scheduleAndRunRequeste
dTasks$1.apply(VintageBuildTreeWorkController.kt:35)
[        ]      at
org.gradle.composite.internal.DefaultIncludedBuildTaskGraph.withNewWorkGraph(Defa
ultIncludedBuildTaskGraph.java:112)
[        ]      at
org.gradle.internal.cc.impl.VintageBuildTreeWorkController.scheduleAndRunRequeste
dTasks(VintageBuildTreeWorkController.kt:35)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeLifecycleController.lambda$schedule
AndRunTasks$1(DefaultBuildTreeLifecycleController.java:77)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeLifecycleController.lambda$runBuild
$4(DefaultBuildTreeLifecycleController.java:120)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$transition$6(StateTran
sitionController.java:169)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:266)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$transition$7(StateTran
sitionController.java:169)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:46
)
[        ]      at
org.gradle.internal.model.StateTransitionController.transition(StateTransitionCon
troller.java:169)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeLifecycleController.runBuild(Defaul
tBuildTreeLifecycleController.java:117)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeLifecycleController.scheduleAndRunT
asks(DefaultBuildTreeLifecycleController.java:77)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeLifecycleController.scheduleAndRunT
asks(DefaultBuildTreeLifecycleController.java:72)
[        ]      at
org.gradle.tooling.internal.provider.ExecuteBuildActionRunner.run(ExecuteBuildAct
ionRunner.java:31)
[        ]      at
org.gradle.launcher.exec.ChainingBuildActionRunner.run(ChainingBuildActionRunner.
java:35)
[        ]      at
org.gradle.internal.buildtree.ProblemReportingBuildActionRunner.run(ProblemReport
ingBuildActionRunner.java:49)
[        ]      at
org.gradle.launcher.exec.BuildOutcomeReportingBuildActionRunner.run(BuildOutcomeR
eportingBuildActionRunner.java:71)
[        ]      at
org.gradle.tooling.internal.provider.FileSystemWatchingBuildActionRunner.run(File
SystemWatchingBuildActionRunner.java:135)
[        ]      at
org.gradle.launcher.exec.BuildCompletionNotifyingBuildActionRunner.run(BuildCompl
etionNotifyingBuildActionRunner.java:41)
[        ]      at
org.gradle.launcher.exec.RootBuildLifecycleBuildActionExecutor.lambda$execute$0(R
ootBuildLifecycleBuildActionExecutor.java:54)
[        ]      at
org.gradle.composite.internal.DefaultRootBuildState.run(DefaultRootBuildState.jav
a:130)
[        ]      at
org.gradle.launcher.exec.RootBuildLifecycleBuildActionExecutor.execute(RootBuildL
ifecycleBuildActionExecutor.java:54)
[        ]      at
org.gradle.internal.buildtree.InitDeprecationLoggingActionExecutor.execute(InitDe
precationLoggingActionExecutor.java:62)
[        ]      at
org.gradle.internal.buildtree.InitProblems.execute(InitProblems.java:36)
[        ]      at
org.gradle.internal.buildtree.DefaultBuildTreeContext.execute(DefaultBuildTreeCon
text.java:40)
[        ]      at
org.gradle.launcher.exec.BuildTreeLifecycleBuildActionExecutor.lambda$execute$0(B
uildTreeLifecycleBuildActionExecutor.java:71)
[        ]      at
org.gradle.internal.buildtree.BuildTreeState.run(BuildTreeState.java:60)
[        ]      at
org.gradle.launcher.exec.BuildTreeLifecycleBuildActionExecutor.execute(BuildTreeL
ifecycleBuildActionExecutor.java:71)
[        ]      at
org.gradle.launcher.exec.RunAsBuildOperationBuildActionExecutor$2.call(RunAsBuild
OperationBuildActionExecutor.java:67)
[        ]      at
org.gradle.launcher.exec.RunAsBuildOperationBuildActionExecutor$2.call(RunAsBuild
OperationBuildActionExecutor.java:63)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$CallableBuildOperation
Worker.execute(DefaultBuildOperationRunner.java:209)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$CallableBuildOperation
Worker.execute(DefaultBuildOperationRunner.java:204)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[   +3 ms]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.call(DefaultBuildOpera
tionRunner.java:53)
[        ]      at
org.gradle.launcher.exec.RunAsBuildOperationBuildActionExecutor.execute(RunAsBuil
dOperationBuildActionExecutor.java:63)
[        ]      at
org.gradle.launcher.exec.RunAsWorkerThreadBuildActionExecutor.lambda$execute$0(Ru
nAsWorkerThreadBuildActionExecutor.java:36)
[        ]      at
org.gradle.internal.work.DefaultWorkerLeaseService.withLocks(DefaultWorkerLeaseSe
rvice.java:263)
[        ]      at
org.gradle.internal.work.DefaultWorkerLeaseService.runAsWorkerThread(DefaultWorke
rLeaseService.java:127)
[        ]      at
org.gradle.launcher.exec.RunAsWorkerThreadBuildActionExecutor.execute(RunAsWorker
ThreadBuildActionExecutor.java:36)
[        ]      at
org.gradle.tooling.internal.provider.continuous.ContinuousBuildActionExecutor.exe
cute(ContinuousBuildActionExecutor.java:110)
[        ]      at
org.gradle.tooling.internal.provider.SubscribableBuildActionExecutor.execute(Subs
cribableBuildActionExecutor.java:64)
[        ]      at
org.gradle.internal.session.DefaultBuildSessionContext.execute(DefaultBuildSessio
nContext.java:46)
[        ]      at
org.gradle.internal.buildprocess.execution.BuildSessionLifecycleBuildActionExecut
or$ActionImpl.apply(BuildSessionLifecycleBuildActionExecutor.java:92)
[        ]      at
org.gradle.internal.buildprocess.execution.BuildSessionLifecycleBuildActionExecut
or$ActionImpl.apply(BuildSessionLifecycleBuildActionExecutor.java:80)
[        ]      at
org.gradle.internal.session.BuildSessionState.run(BuildSessionState.java:71)
[        ]      at
org.gradle.internal.buildprocess.execution.BuildSessionLifecycleBuildActionExecut
or.execute(BuildSessionLifecycleBuildActionExecutor.java:62)
[        ]      at
org.gradle.internal.buildprocess.execution.BuildSessionLifecycleBuildActionExecut
or.execute(BuildSessionLifecycleBuildActionExecutor.java:41)
[        ]      at
org.gradle.internal.buildprocess.execution.StartParamsValidatingActionExecutor.ex
ecute(StartParamsValidatingActionExecutor.java:64)
[        ]      at
org.gradle.internal.buildprocess.execution.StartParamsValidatingActionExecutor.ex
ecute(StartParamsValidatingActionExecutor.java:32)
[        ]      at
org.gradle.internal.buildprocess.execution.SessionFailureReportingActionExecutor.
execute(SessionFailureReportingActionExecutor.java:51)
[   +1 ms]      at
org.gradle.internal.buildprocess.execution.SessionFailureReportingActionExecutor.
execute(SessionFailureReportingActionExecutor.java:39)
[        ]      at
org.gradle.internal.buildprocess.execution.SetupLoggingActionExecutor.execute(Set
upLoggingActionExecutor.java:47)
[        ]      at
org.gradle.internal.buildprocess.execution.SetupLoggingActionExecutor.execute(Set
upLoggingActionExecutor.java:31)
[        ]      at
org.gradle.launcher.daemon.server.exec.ExecuteBuild.doBuild(ExecuteBuild.java:70)
[        ]      at
org.gradle.launcher.daemon.server.exec.BuildCommandOnly.execute(BuildCommandOnly.
java:37)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.WatchForDisconnection.execute(WatchForDisc
onnection.java:39)
[   +2 ms]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.ResetDeprecationLogger.execute(ResetDeprec
ationLogger.java:29)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[   +1 ms]      at
org.gradle.launcher.daemon.server.exec.RequestStopIfSingleUsedDaemon.execute(Requ
estStopIfSingleUsedDaemon.java:35)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.ForwardClientInput.lambda$execute$0(Forwar
dClientInput.java:40)
[        ]      at
org.gradle.internal.daemon.clientinput.ClientInputForwarder.forwardInput(ClientIn
putForwarder.java:80)
[   +2 ms]      at
org.gradle.launcher.daemon.server.exec.ForwardClientInput.execute(ForwardClientIn
put.java:37)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.LogAndCheckHealth.execute(LogAndCheckHealt
h.java:64)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.LogToClient.doBuild(LogToClient.java:63)
[        ]      at
org.gradle.launcher.daemon.server.exec.BuildCommandOnly.execute(BuildCommandOnly.
java:37)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.EstablishBuildEnvironment.doBuild(Establis
hBuildEnvironment.java:84)
[        ]      at
org.gradle.launcher.daemon.server.exec.BuildCommandOnly.execute(BuildCommandOnly.
java:37)
[        ]      at
org.gradle.launcher.daemon.server.api.DaemonCommandExecution.proceed(DaemonComman
dExecution.java:104)
[        ]      at
org.gradle.launcher.daemon.server.exec.StartBuildOrRespondWithBusy$1.run(StartBui
ldOrRespondWithBusy.java:52)
[        ]      at
org.gradle.launcher.daemon.server.DaemonStateCoordinator.lambda$runCommand$0(Daem
onStateCoordinator.java:321)
[        ]      at
org.gradle.internal.concurrent.ExecutorPolicy$CatchAndRecordFailures.onExecute(Ex
ecutorPolicy.java:64)
[        ]      at
org.gradle.internal.concurrent.AbstractManagedExecutor$1.run(AbstractManagedExecu
tor.java:48)
[        ]      at
java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
[        ]      at
java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
[        ]      at java.base/java.lang.Thread.run(Unknown Source)
[        ] Caused by: org.gradle.api.ProjectConfigurationException: A problem
occurred configuring project ':gradle'.
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator.wrapException(Lifecycl
eProjectEvaluator.java:84)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator.addConfigurationFailur
e(LifecycleProjectEvaluator.java:77)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator.access$500(LifecyclePr
ojectEvaluator.java:55)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator$EvaluateProject.lambda
$run$0(LifecycleProjectEvaluator.java:111)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.lamb
da$applyToMutableState$1(DefaultProjectStateRegistry.java:411)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.lamb
da$fromMutableState$2(DefaultProjectStateRegistry.java:434)
[        ]      at
org.gradle.internal.work.DefaultWorkerLeaseService.withReplacedLocks(DefaultWorke
rLeaseService.java:359)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.from
MutableState(DefaultProjectStateRegistry.java:434)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.appl
yToMutableState(DefaultProjectStateRegistry.java:410)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator$EvaluateProject.run(Li
fecycleProjectEvaluator.java:100)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:29)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:26)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.run(DefaultBuildOperat
ionRunner.java:47)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator.evaluate(LifecycleProj
ectEvaluator.java:72)
[        ]      at
org.gradle.api.internal.project.DefaultProject.evaluateUnchecked(DefaultProject.j
ava:828)
[        ]      at
org.gradle.api.internal.project.ProjectLifecycleController.lambda$ensureSelfConfi
gured$2(ProjectLifecycleController.java:85)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$doTransition$14(StateT
ransitionController.java:255)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:266)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:254)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$maybeTransitionIfNotCu
rrentlyTransitioning$10(StateTransitionController.java:199)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:36
)
[        ]      at
org.gradle.internal.model.StateTransitionController.maybeTransitionIfNotCurrently
Transitioning(StateTransitionController.java:195)
[        ]      at
org.gradle.api.internal.project.ProjectLifecycleController.ensureSelfConfigured(P
rojectLifecycleController.java:85)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.ensu
reConfigured(DefaultProjectStateRegistry.java:385)
[        ]      at
org.gradle.execution.TaskPathProjectEvaluator.configure(TaskPathProjectEvaluator.
java:42)
[        ]      at
org.gradle.execution.TaskPathProjectEvaluator.configureHierarchy(TaskPathProjectE
valuator.java:56)
[        ]      at
org.gradle.configuration.DefaultProjectsPreparer.prepareProjects(DefaultProjectsP
reparer.java:50)
[        ]      at
org.gradle.configuration.BuildTreePreparingProjectsPreparer.prepareProjects(Build
TreePreparingProjectsPreparer.java:65)
[        ]      at
org.gradle.configuration.BuildOperationFiringProjectsPreparer$ConfigureBuild.run(
BuildOperationFiringProjectsPreparer.java:52)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:29)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:26)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.run(DefaultBuildOperat
ionRunner.java:47)
[        ]      at
org.gradle.configuration.BuildOperationFiringProjectsPreparer.prepareProjects(Bui
ldOperationFiringProjectsPreparer.java:40)
[        ]      at
org.gradle.initialization.VintageBuildModelController.lambda$prepareProjects$2(Vi
ntageBuildModelController.java:84)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$doTransition$14(StateT
ransitionController.java:255)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:266)
[        ]      at
org.gradle.internal.model.StateTransitionController.doTransition(StateTransitionC
ontroller.java:254)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$transitionIfNotPreviou
sly$11(StateTransitionController.java:213)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:36
)
[        ]      at
org.gradle.internal.model.StateTransitionController.transitionIfNotPreviously(Sta
teTransitionController.java:209)
[        ]      at
org.gradle.initialization.VintageBuildModelController.prepareProjects(VintageBuil
dModelController.java:84)
[        ]      at
org.gradle.initialization.VintageBuildModelController.getConfiguredModel(VintageB
uildModelController.java:64)
[        ]      at
org.gradle.internal.model.StateTransitionController.lambda$notInState$3(StateTran
sitionController.java:132)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:46
)
[        ]      at
org.gradle.internal.model.StateTransitionController.notInState(StateTransitionCon
troller.java:128)
[        ]      at
org.gradle.internal.build.DefaultBuildLifecycleController.configureProjects(Defau
ltBuildLifecycleController.java:128)
[        ]      at
org.gradle.internal.build.AbstractBuildState.ensureProjectsConfigured(AbstractBui
ldState.java:145)
[        ]      at
org.gradle.internal.buildtree.BuildInclusionCoordinator$BuildSynchronizer.lambda$
withLock$0(BuildInclusionCoordinator.java:66)
[        ]      at
org.gradle.internal.work.DefaultSynchronizer.withLock(DefaultSynchronizer.java:36
)
[        ]      at
org.gradle.internal.buildtree.BuildInclusionCoordinator$BuildSynchronizer.withLoc
k(BuildInclusionCoordinator.java:60)
[        ]      at
org.gradle.internal.buildtree.BuildInclusionCoordinator.withLockForBuild(BuildInc
lusionCoordinator.java:147)
[        ]      at
org.gradle.internal.buildtree.BuildInclusionCoordinator.prepareForPluginResolutio
n(BuildInclusionCoordinator.java:117)
[        ]      at
org.gradle.internal.composite.DefaultBuildIncluder.prepareForPluginResolution(Def
aultBuildIncluder.java:93)
[        ]      at
org.gradle.composite.internal.plugins.CompositeBuildPluginResolverContributor$Com
positeBuildPluginResolver.resolveFromIncludedPluginBuilds(CompositeBuildPluginRes
olverContributor.java:138)
[        ]      at
org.gradle.composite.internal.plugins.CompositeBuildPluginResolverContributor$Com
positeBuildPluginResolver.doResolve(CompositeBuildPluginResolverContributor.java:
115)
[        ]      at
java.base/java.util.concurrent.ConcurrentHashMap.computeIfAbsent(Unknown Source)
[        ]      at
org.gradle.composite.internal.plugins.CompositeBuildPluginResolverContributor$Com
positeBuildPluginResolver.resolve(CompositeBuildPluginResolverContributor.java:10
4)
[        ]      at
org.gradle.plugin.use.resolve.internal.CompositePluginResolver.resolve(CompositeP
luginResolver.java:36)
[        ]      at
org.gradle.plugin.use.resolve.internal.AlreadyOnClasspathPluginResolver.resolve(A
lreadyOnClasspathPluginResolver.java:65)
[        ]      at
org.gradle.plugin.use.internal.DefaultPluginRequestApplicator.resolvePluginReques
t(DefaultPluginRequestApplicator.java:189)
[        ]      ... 159 more
[        ] Caused by: java.io.UncheckedIOException: Could not read workspace
metadata from
/Users/bintang/.gradle/caches/8.12/kotlin-dsl/accessors/66a4afc4ecce242057c438fda13
8d2fe/metadata.bin
[        ]      at
org.gradle.internal.execution.history.impl.DefaultImmutableWorkspaceMetadataStore
.loadWorkspaceMetadata(DefaultImmutableWorkspaceMetadataStore.java:60)
[        ]      at
org.gradle.internal.execution.steps.AssignImmutableWorkspaceStep.loadImmutableWor
kspaceIfConsistent(AssignImmutableWorkspaceStep.java:147)
[        ]      at
org.gradle.internal.execution.steps.AssignImmutableWorkspaceStep.loadImmutableWor
kspaceIfExists(AssignImmutableWorkspaceStep.java:129)
[        ]      at
org.gradle.internal.execution.steps.AssignImmutableWorkspaceStep.execute(AssignIm
mutableWorkspaceStep.java:120)
[        ]      at
org.gradle.internal.execution.steps.AssignImmutableWorkspaceStep.execute(AssignIm
mutableWorkspaceStep.java:90)
[        ]      at
org.gradle.internal.execution.steps.ChoosePipelineStep.execute(ChoosePipelineStep
.java:38)
[        ]      at
org.gradle.internal.execution.steps.ChoosePipelineStep.execute(ChoosePipelineStep
.java:23)
[        ]      at
org.gradle.internal.execution.steps.ExecuteWorkBuildOperationFiringStep.lambda$ex
ecute$2(ExecuteWorkBuildOperationFiringStep.java:67)
[        ]      at java.base/java.util.Optional.orElseGet(Unknown Source)
[        ]      at
org.gradle.internal.execution.steps.ExecuteWorkBuildOperationFiringStep.execute(E
xecuteWorkBuildOperationFiringStep.java:67)
[        ]      at
org.gradle.internal.execution.steps.ExecuteWorkBuildOperationFiringStep.execute(E
xecuteWorkBuildOperationFiringStep.java:39)
[        ]      at
org.gradle.internal.execution.steps.IdentityCacheStep.execute(IdentityCacheStep.j
ava:46)
[        ]      at
org.gradle.internal.execution.steps.IdentityCacheStep.execute(IdentityCacheStep.j
ava:34)
[        ]      at
org.gradle.internal.execution.steps.IdentifyStep.execute(IdentifyStep.java:48)
[        ]      at
org.gradle.internal.execution.steps.IdentifyStep.execute(IdentifyStep.java:35)
[        ]      at
org.gradle.internal.execution.impl.DefaultExecutionEngine$1.execute(DefaultExecut
ionEngine.java:61)
[        ]      at
org.gradle.kotlin.dsl.accessors.ProjectAccessorsClassPathGenerator.buildAccessors
ClassPathFor(AccessorsClassPath.kt:113)
[        ]      at
org.gradle.kotlin.dsl.accessors.ProjectAccessorsClassPathGenerator.access$buildAc
cessorsClassPathFor(AccessorsClassPath.kt:79)
[        ]      at
org.gradle.kotlin.dsl.accessors.ProjectAccessorsClassPathGenerator.projectAccesso
rsClassPath(AccessorsClassPath.kt:91)
[        ]      at
org.gradle.kotlin.dsl.provider.StandardKotlinScriptEvaluator$InterpreterHost.acce
ssorsClassPathFor(KotlinScriptEvaluator.kt:195)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter$ProgramHost.accessorsClassPathFor(Int
erpreter.kt:449)
[        ]      at Program.execute(Unknown Source)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter$ProgramHost.eval(Interpreter.kt:516)
[        ]      at
org.gradle.kotlin.dsl.execution.Interpreter.eval(Interpreter.kt:194)
[        ]      at
org.gradle.kotlin.dsl.provider.StandardKotlinScriptEvaluator.evaluate(KotlinScrip
tEvaluator.kt:130)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPluginFactory$create$1.invoke(KotlinSc
riptPluginFactory.kt:62)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPluginFactory$create$1.invoke(KotlinSc
riptPluginFactory.kt:48)
[        ]      at
org.gradle.kotlin.dsl.provider.KotlinScriptPlugin.apply(KotlinScriptPlugin.kt:35)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin$1.run(BuildOperationScriptPlu
gin.java:68)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:29)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$1.execute(DefaultBuild
OperationRunner.java:26)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:66)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner$2.execute(DefaultBuild
OperationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:166)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.execute(DefaultBuildOp
erationRunner.java:59)
[        ]      at
org.gradle.internal.operations.DefaultBuildOperationRunner.run(DefaultBuildOperat
ionRunner.java:47)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin.lambda$apply$0(BuildOperation
ScriptPlugin.java:65)
[        ]      at
org.gradle.internal.code.DefaultUserCodeApplicationContext.apply(DefaultUserCodeA
pplicationContext.java:44)
[        ]      at
org.gradle.configuration.BuildOperationScriptPlugin.apply(BuildOperationScriptPlu
gin.java:65)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.lamb
da$applyToMutableState$1(DefaultProjectStateRegistry.java:411)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.from
MutableState(DefaultProjectStateRegistry.java:429)
[        ]      at
org.gradle.api.internal.project.DefaultProjectStateRegistry$ProjectStateImpl.appl
yToMutableState(DefaultProjectStateRegistry.java:410)
[        ]      at
org.gradle.configuration.project.BuildScriptProcessor.execute(BuildScriptProcesso
r.java:46)
[        ]      at
org.gradle.configuration.project.BuildScriptProcessor.execute(BuildScriptProcesso
r.java:27)
[        ]      at
org.gradle.configuration.project.ConfigureActionsProjectEvaluator.evaluate(Config
ureActionsProjectEvaluator.java:35)
[        ]      at
org.gradle.configuration.project.LifecycleProjectEvaluator$EvaluateProject.lambda
$run$0(LifecycleProjectEvaluator.java:109)
[        ]      ... 223 more
[        ] Caused by: java.io.FileNotFoundException:
/Users/bintang/.gradle/caches/8.12/kotlin-dsl/accessors/66a4afc4ecce242057c438fda13
8d2fe/metadata.bin (No such file or directory)
[        ]      at java.base/java.io.FileInputStream.open0(Native Method)
[        ]      at java.base/java.io.FileInputStream.open(Unknown Source)
[        ]      at java.base/java.io.FileInputStream.<init>(Unknown Source)
[        ]      at
org.gradle.internal.execution.history.impl.DefaultImmutableWorkspaceMetadataStore
.loadWorkspaceMetadata(DefaultImmutableWorkspaceMetadataStore.java:45)
[        ]      ... 268 more
[        ] BUILD FAILED in 1s
[        ] Watched directory hierarchies:
[/Users/bintang/software/flutter/packages/flutter_tools/gradle,
/Users/bintang/development/ksi/ams-ksi-mobile/android]
[        ] Running Gradle task 'assembleDebug'... (completed in 1,238ms)
[   +2 ms] [!] Gradle threw an error while downloading artifacts from the
network.
[   +4 ms] Error: Gradle task assembleDebug failed with exit code 1
[        ] "flutter run" took 44,302ms.
[   +4 ms] executing: sw_vers -productName
[  +15 ms] Exit code 0 from: sw_vers -productName
[        ] macOS
[        ] executing: sw_vers -productVersion
[  +10 ms] Exit code 0 from: sw_vers -productVersion
[        ] 15.5
[        ] executing: sw_vers -buildVersion
[  +11 ms] Exit code 0 from: sw_vers -buildVersion
[        ] 24F74
[        ] executing: uname -m
[   +4 ms] Exit code 0 from: uname -m
[        ] arm64
[  +10 ms] 
           #0      throwToolExit
(package:flutter_tools/src/base/common.dart:34:3)
           #1      RunCommand.runCommand
(package:flutter_tools/src/commands/run.dart:872:9)
           <asynchronous suspension>
           #2      FlutterCommand.run.<anonymous closure>
           (package:flutter_tools/src/runner/flutter_command.dart:1581:27)
           <asynchronous suspension>
           #3      AppContext.run.<anonymous closure>
           (package:flutter_tools/src/base/context.dart:154:19)
           <asynchronous suspension>
           #4      CommandRunner.runCommand
(package:args/command_runner.dart:212:13)
           <asynchronous suspension>
           #5      FlutterCommandRunner.runCommand.<anonymous closure>
           (package:flutter_tools/src/runner/flutter_command_runner.dart:503:9)
           <asynchronous suspension>
           #6      AppContext.run.<anonymous closure>
           (package:flutter_tools/src/base/context.dart:154:19)
           <asynchronous suspension>
           #7      FlutterCommandRunner.runCommand
           (package:flutter_tools/src/runner/flutter_command_runner.dart:438:5)
           <asynchronous suspension>
           #8      run.<anonymous closure>.<anonymous closure>
           (package:flutter_tools/runner.dart:98:11)
           <asynchronous suspension>
           #9      AppContext.run.<anonymous closure>
           (package:flutter_tools/src/base/context.dart:154:19)
           <asynchronous suspension>
           #10     main (package:flutter_tools/executable.dart:101:3)
           <asynchronous suspension>
           
           
[        ] Running 3 shutdown hooks
[   +2 ms] Shutdown hooks complete
[ +103 ms] exiting with code 1