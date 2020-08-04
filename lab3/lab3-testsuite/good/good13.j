;; BEGIN HEADER

.class public good13
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

  invokestatic good13/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 4
  .limit stack  100
  ;; int n, i;
  ;; (int) n = readInt ();
  invokestatic Runtime/readInt()I
  nop
  dup
  istore 0
  pop 
  ;; (int) i = 2;
  ldc 2
  nop
  dup
  istore 1
  pop 
  ;; while (i int.<= n)
  L0:
  ldc 1
  iload 1
  iload 0
  if_icmple L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   bool iPrime = true;
  ;;   int j = 2;
  ;;   while (j int.* j int.<= i && iPrime) {
  ;;     if (i int./ j int.* j int.== i) {
  ;;       (bool) iPrime = false;
  ;;       }
  ;;     else {
  ;;       }
  ;;     (int) j ++;
  ;;     }
  ;;   if (iPrime && n int./ i int.* i int.== n) {
  ;;     (void) printInt (i);
  ;;     (int) n = n int./ i;
  ;;     }
  ;;   else {
  ;;     (int) i ++;
  ;;     }
  ;;   }
  ;; bool iPrime = true;
  ldc 1
  istore 2
  ;; int j = 2;
  ldc 2
  istore 3
  ;; while (j int.* j int.<= i && iPrime)
  L3:
  ldc 1
  iload 3
  iload 3
  imul
  iload 1
  if_icmple L5
  pop 
  ldc 0
  L5:
  ifeq L6
  iload 2
  ifeq L6
  ldc 1
  goto L7
  L6:
  ldc 0
  L7:
  ifeq L4
  ;; {
  ;;   if (i int./ j int.* j int.== i) {
  ;;     (bool) iPrime = false;
  ;;     }
  ;;   else {
  ;;     }
  ;;   (int) j ++;
  ;;   }
  ;; if (i int./ j int.* j int.== i) {
  ;;   (bool) iPrime = false;
  ;;   }
  ;; else {
  ;;   }
  ldc 1
  iload 1
  iload 3
  idiv
  iload 3
  imul
  iload 1
  if_icmpeq L10
  pop 
  ldc 0
  L10:
  ifeq L9
  ;; {
  ;;   (bool) iPrime = false;
  ;;   }
  ;; (bool) iPrime = false;
  ldc 0
  dup
  istore 2
  pop 
  goto L8
  L9:
  ;; {
  ;;   }
  L8:
  ;; (int) j ++;
  iload 3
  dup
  ldc 1
  iadd
  istore 3
  pop 
  goto L3
  L4:
  ;; if (iPrime && n int./ i int.* i int.== n) {
  ;;   (void) printInt (i);
  ;;   (int) n = n int./ i;
  ;;   }
  ;; else {
  ;;   (int) i ++;
  ;;   }
  iload 2
  ifeq L13
  ldc 1
  iload 0
  iload 1
  idiv
  iload 1
  imul
  iload 0
  if_icmpeq L15
  pop 
  ldc 0
  L15:
  ifeq L13
  ldc 1
  goto L14
  L13:
  ldc 0
  L14:
  ifeq L12
  ;; {
  ;;   (void) printInt (i);
  ;;   (int) n = n int./ i;
  ;;   }
  ;; (void) printInt (i);
  iload 1
  invokestatic Runtime/printInt(I)V

  ;; (int) n = n int./ i;
  iload 0
  iload 1
  idiv
  nop
  dup
  istore 0
  pop 
  goto L11
  L12:
  ;; {
  ;;   (int) i ++;
  ;;   }
  ;; (int) i ++;
  iload 1
  dup
  ldc 1
  iadd
  istore 1
  pop 
  L11:
  goto L0
  L1:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
