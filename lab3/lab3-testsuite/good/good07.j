;; BEGIN HEADER

.class public good07
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

  invokestatic good07/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int x = readInt ();
  invokestatic Runtime/readInt()I
  istore 0
  ;; int d = x int./ 2;
  iload 0
  ldc 2
  idiv
  istore 1
  ;; while (d int.> 1)
  L0:
  ldc 1
  iload 1
  ldc 1
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   if (d int.* (x int./ d) int.== x) (void) printInt (d);
  ;;   else {
  ;;     }
  ;;   (int) d --;
  ;;   }
  ;; if (d int.* (x int./ d) int.== x) (void) printInt (d);
  ;; else {
  ;;   }
  ldc 1
  iload 1
  iload 0
  iload 1
  idiv
  imul
  iload 0
  if_icmpeq L5
  pop 
  ldc 0
  L5:
  ifeq L4
  ;; (void) printInt (d);
  iload 1
  invokestatic Runtime/printInt(I)V

  goto L3
  L4:
  ;; {
  ;;   }
  L3:
  ;; (int) d --;
  iload 1
  dup
  ldc 1
  isub
  istore 1
  pop 
  goto L0
  L1:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
