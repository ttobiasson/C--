;; BEGIN HEADER

.class public return_in_block
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

  invokestatic return_in_block/main()I
  pop
  return

.end method

;; END HEADER

.method public static niam()I
  .limit locals 0
  .limit stack  100
  ;; {
  ;;   return (int) 99;
  ;;   }
  ;; return (int) 99;
  ldc 99
  ireturn 
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; {
  ;;   (void) printInt (niam ());
  ;;   return (int) 0;
  ;;   }
  ;; (void) printInt (niam ());
  invokestatic return_in_block/niam()I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
  ;; (void) printInt (2);
  ldc 2
  invokestatic Runtime/printInt(I)V

ireturn

.end method
