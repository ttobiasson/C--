;; BEGIN HEADER

.class public good15
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

  invokestatic good15/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int i = 1;
  ldc 1
  istore 0
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (bool) true || i ++ int.!= 45;
  ldc 1
  ifeq L0
  ldc 1
  goto L1
  L0:
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 45
  if_icmpne L3
  pop 
  ldc 0
  L3:
  ifeq L2
  ldc 1
  goto L1
  L2:
  ldc 0
  L1:
  pop 
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (bool) false || i ++ int.>= 0;
  ldc 0
  ifeq L4
  ldc 1
  goto L5
  L4:
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmpge L7
  pop 
  ldc 0
  L7:
  ifeq L6
  ldc 1
  goto L5
  L6:
  ldc 0
  L5:
  pop 
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (bool) true && i ++ int.< 0;
  ldc 1
  ifeq L8
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmplt L10
  pop 
  ldc 0
  L10:
  ifeq L8
  ldc 1
  goto L9
  L8:
  ldc 0
  L9:
  pop 
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (bool) false && i ++ int.> 0;
  ldc 0
  ifeq L11
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmpgt L13
  pop 
  ldc 0
  L13:
  ifeq L11
  ldc 1
  goto L12
  L11:
  ldc 0
  L12:
  pop 
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; int j = 0;
  ldc 0
  istore 1
  ;; if (34 int.< 6 && j int.< 0) {
  ;;   (void) printInt (i);
  ;;   }
  ;; else {
  ;;   (void) printInt (42);
  ;;   }
  ldc 1
  ldc 34
  ldc 6
  if_icmplt L16
  pop 
  ldc 0
  L16:
  ifeq L17
  ldc 1
  iload 1
  ldc 0
  if_icmplt L19
  pop 
  ldc 0
  L19:
  ifeq L17
  ldc 1
  goto L18
  L17:
  ldc 0
  L18:
  ifeq L15
  ;; {
  ;;   (void) printInt (i);
  ;;   }
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  goto L14
  L15:
  ;; {
  ;;   (void) printInt (42);
  ;;   }
  ;; (void) printInt (42);
  ldc 42
  invokestatic Runtime/printInt(I)V

  L14:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
