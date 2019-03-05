;kimden kime maliyet 3 lüsü şeklinde veri yapısı. defterimde var graph. Dr.racket 3 arama algoritması uniform cost searc başlıgı
(define harita
 (list (list 1 2 1) ; 1 den 2 ye yol var maliyeti 1
       (list 1 3 3) ; 1 den 3 e yol var maliyeti 3
       (list 2 3 2) ; 2 den 3 e yol var maliyeti 2. alt satırda da 3 den 2 ye yol var maliyeti 2. cycle var dikkat.
       (list 2 4 2)
       (list 2 6 8)
       (list 3 5 1)
       (list 5 12 2)
       ))
; iki alternatiften ucuz maliyet olanı döndürür
(define (choose alt1 alt2) (if (empty? alt2) alt1 (if (< (first (rest alt1)) (first (rest alt2)) ) alt1 alt2)))

;alt fonksiyonu bir dugumden gidilebilecek alternatifleri bul. parametre olarak verilen dügüm ilk elemanlar. yani=  kimden./ amaç = kime ve kimlere
(define (alt list dugum)                 
     (if (empty? list) '()
         (if (= dugum (first (first list))) (cons (rest (first list)) (alt (rest list) dugum)) (alt (rest list) dugum))))
;min alt fonksiyonu alternatiflerden en ucuz maliyetli olanını alıcak!!!
(define (minAlt list)(if(empty? list) list (choose(first list)(minAlt(rest list))))) ; choose fonksiyonunda sadece alt2 emptymi kontrol yapmamızın sebebi left recursion yapmamızdı dikkat et

(alt harita 2)
(minAlt (alt harita 3))


(define (aStar alist start finish alist2)
  (if (empty? alist) alist
      (cons start ;cons start , dolastıgımız dügümleri görmek icin !!!!
            (if(empty? (alt alist start)) '() ;dugumden gidilebilecek alternatifler bos ise bos döndür
               (if (= finish (first(minAlt (alt alist start))))
                   (list(first(minAlt (alt alist start)))) ; alternatiflerin en iyisi benim aradıgıma eşitse onu artık döndür
                   (aStar alist (first(minAlt  (if (empty? alist2) (alt alist start)(append  (alt alist start) alist2)) )) finish (if (empty? alist2) (remove(minAlt (alt alist start))(alt alist start)) (append (remove(minAlt (alt alist start))(alt alist start)) alist2)) ))))))
; çağırırken mantık şu. öncelikle alist2 yi boş yolla. bitme kosulları yazılı esas olay son satırda. son satırda finish kısmından sonra kontrol var
;eğer list2 boş ise ilk çağırıştaki alternatifler listesini en iyi alternatifi aralarından cıkararak (remove ederek) döndür. eğer dolu ise, bu çağırıştaki alternatiflerle onu append et birleştir.
; sonra 2. parametre olan alist kısmının recursive i içinde durum şu. en iyi alternatifi buluyo fakat alist2 ile append edilip deneniyor en iyi bulma işlemi.
;yani dolaşılan bütün düğümler arasındaki en iyi ihtimali buluyor. A STAR algoritması !!!!


(aStar harita 1 4 '())

