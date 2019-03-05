(define kromatin (list (list 3 3 4 2)
                        (list 3 1 1 9)
                        (list 4 1 2 4)))
;alttaki sezgisel fonkisyonuna yardımcı fonksiyon yazdık
(define (sezgiselYardimci istenenDurum alist) (- (first istenenDurum) (first alist)))

(define (uzaklik istenenDurum alist)(if (empty? istenenDurum) 0
                                        (if (empty? alist)0
                                            (+ (sezgiselYardimci istenenDurum alist)(uzaklik (rest istenenDurum)(rest alist)))))) ;sezgisel hesap yapıyoruz
; bu sezgisel hesap yolladıgım listenin istenen durum listesine uzaklıgı yakınlığı
(define(bulundumu istenenDurum alist) (if (= (uzaklik istenenDurum (first alist)) 0) 1
                                          (if (empty? (rest alist)) 0
                                                  (bulundumu istenenDurum (rest alist)))))

(bulundumu (list 4 3 2 4) kromatin) 
(define (toplam alist) (if(empty? alist) 0 (+ (first alist) (toplam (rest alist)) ))) ;
(define (secim alist1 alist2) (if (> (toplam alist1) (toplam alist2)) alist1 alist2))
(define (eniyi alist)(if (empty? alist) '() (secim (first alist) (eniyi (rest alist)))))
(define(eniyi2 alist)(list (eniyi alist) (eniyi (remove (eniyi alist) alist))))

 
;gen degisimi yapar
(define (crossingOverYardimci alist1 alist2) (list (list (first alist2) (second alist2) (third alist1) (fourth alist1)) (list (first alist1) (second alist1) (third alist2) (fourth alist2))))

;(crossingOverYardimci (second kromatin) (first kromatin))

;alttaki fonksiyon listenin en iyi 2 elemanını listeden atar
(define (listeGuncelleYardimci alist)(remove (second(eniyi2 alist ))(remove (first(eniyi2 alist )) alist)))
;en iyi 2 elemanı listeden atılmış listeye, en iyi 2 eleman arasında gen degişimi yapılmış hallerini listeye atar!!
(define (listeGuncelle alist) (append (crossingOverYardimci (first (eniyi2 alist ))(second (eniyi2 alist ))) (listeGuncelleYardimci alist)))
kromatin
(eniyi2 kromatin)
(listeGuncelle kromatin)
(eniyi2 (listeGuncelle kromatin))
(listeGuncelle (listeGuncelle kromatin))

(define (crossingOver alist istenenDurum adim) (if (= adim 0) 0
                                                   (if (empty? alist) 0
                                                   (if (= (bulundumu istenenDurum alist) 1) 1
                                                       (crossingOver (listeGuncelle alist) istenenDurum (- adim 1))))))
(crossingOver kromatin (list 4 1 1 9) 4)

                                                   
