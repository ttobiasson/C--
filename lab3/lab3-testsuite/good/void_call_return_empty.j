;; BEGIN HEADER

.class public void_call_return_empty
.super java/lang/Object

.method public <init>()V
  .limit locals 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic void_call_return_empty/main()I
  pop
  return

.end method

;; END HEADER

.method public static empty()V
  .limit locals 0
  .limit stack  100
return

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) empty ();
  invokestatic void_call_return_empty/empty()V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
