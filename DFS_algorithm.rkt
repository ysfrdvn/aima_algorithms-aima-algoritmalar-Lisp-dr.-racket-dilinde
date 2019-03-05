(define myTree(list 53
              (list 25
                    (list 4 '() '())
                    (list 11 '() '()))
              (list 17 '() '())))
(define (root tree) (first tree)) ;kökü
(define (left tree) (first (rest tree)));solu
(define (right tree) (first (rest (rest tree))));sagı 

;agactaki dügüm sayısını buluyo
(define (count atree)(if(empty? atree) 0
                        (+ (count (left atree)) (count (right atree)) 1)))
(count myTree)

(define (DFS atree anode) (if (empty? atree) 0
                              (if (> (DFS (left atree) anode) 0)
                                  (DFS (left atree) anode)
                                  (if (> (DFS (right atree) anode) 0)
                                      (DFS (right atree) anode)
                                      (if (= anode (root atree)) (count atree) 0)))))

(DFS myTree 44)
                              
                              
