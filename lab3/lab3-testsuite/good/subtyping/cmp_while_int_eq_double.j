;; BEGIN HEADER

.class public cmp_while_int_eq_double
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

  invokestatic cmp_while_int_eq_double/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; while (3 double.== 3.1)
  L0:
  ldc2_w 3.1
  ldc 3
  i2d
  dcmpg
  ifeq L2
  ldc 0
  goto L3
  L2:
  ldc 1
  L3:
  ifeq L1
  ;; {
  ;;   }
  goto L0
  L1:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
