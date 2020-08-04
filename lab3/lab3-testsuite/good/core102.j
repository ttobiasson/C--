;; BEGIN HEADER

.class public core102
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

  invokestatic core102/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; while (2 int.+ 5 int.* 6 int./ 5 int.- 67 int.> 5)
  L0:
  ldc 1
  ldc 2
  ldc 5
  ldc 6
  imul
  ldc 5
  idiv
  iadd
  ldc 67
  isub
  ldc 5
  if_icmpgt L2
  pop 
  ldc 0
  L2:
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
