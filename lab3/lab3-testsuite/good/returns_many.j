;; BEGIN HEADER

.class public returns_many
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

  invokestatic returns_many/main()I
  pop
  return

.end method

;; END HEADER

.method public static r()I
  .limit locals 0
  .limit stack  100
  ;; return (int) 12;
  ldc 12
  ireturn 
  ;; return (int) 2;
  ldc 2
  ireturn 
  ;; return (int) 3;
  ldc 3
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (r ());
  invokestatic returns_many/r()I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
  ;; return (int) 2;
  ldc 2
  ireturn 
ireturn

.end method
