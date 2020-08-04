;; BEGIN HEADER

.class public fun_app_incorrect_type_built_in
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

  invokestatic fun_app_incorrect_type_built_in/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printDouble (99);
  ldc 99
  i2d
  invokestatic Runtime/printDouble(D)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
