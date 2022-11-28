; Initial facts
(deffacts start
    (get-HBsAg)
    (get-anti-HDV)
    (get-anti-HBc)
    (get-anti-HBs)
    (get-IgM-anti-HBc))

; Input HBsAG
(defrule get-HBsAg
    ?f <- (get-HBsAg)
    =>
    (retract ?f)
    (printout t "HBsAg? ")
    (assert (HBsAg (read))))

(defrule bad-HBsAg
    ?f <- (HBsAg ~positive&~negative)
    =>
    (retract ?f)
    (assert (get-HBsAg)))

; Input anti-HDV
(defrule get-anti-HDV
    (HBsAg positive)
    ?f <- (get-anti-HDV)
    =>
    (retract ?f)
    (printout t "anti-HDV? ")
    (assert (anti-HDV(read))))

(defrule bad-anti-HDV
    ?f <- (anti-HDV ~positive&~negative)
    =>
    (retract ?f)
    (assert (get-anti-HDV)))

; Input anti-HBc
(defrule get-anti-HBc
    (or 
        (anti-HDV negative)
        (and (HBsAg negative) (anti-HBs positive|negative))
    )
    ?f <- (get-anti-HBc)
    =>
    (retract ?f)
    (printout t "anti-HBc? ")
    (assert (anti-HBc(read))))

(defrule bad-anti-HBc
    ?f <- (anti-HBc ~positive&~negative)
    =>
    (retract ?f)
    (assert (get-anti-HBc)))

; Input anti-HBs
(defrule get-anti-HBs
    ?f <- (get-anti-HBs)
    (or
        (and (anti-HBc positive) (HBsAg positive))
        (HBsAg negative)
    )
    =>
    (retract ?f)
    (printout t "anti-HBs? ")
    (assert (anti-HBs(read))))

(defrule bad-anti-HBs
    ?f <- (anti-HBs ~positive&~negative)
    =>
    (retract ?f)
    (assert (get-anti-HBs)))

; Input IgM-anti-HBc
(defrule get-IgM-anti-HBc
    ?f <- (get-IgM-anti-HBc)
    (HBsAg positive)
    (anti-HBs negative)
    =>
    (retract ?f)
    (printout t "IgM anti-HBc? ")
    (assert (IgM-anti-HBc(read))))

(defrule bad-IgM-anti-HBc
    ?f <- (IgM-anti-HBc ~positive&~negative)
    =>
    (retract ?f)
    (assert (get-IgM-anti-HBc)))

; Output
(defrule Hepatitis-B+D 
    (anti-HDV positive)
    =>
    (printout t crlf "Hasil Prediksi = Hepatitis B+D" crlf))

(defrule Acute-infection
    (IgM-anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Acute infection" crlf))

(defrule Chronic-infection
    (IgM-anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Chronic infection" crlf))

(defrule Uncertain-configuration
    (HBsAg positive)
    (or (anti-HBc negative) (anti-HBs positive))
    =>
    (printout t crlf "Hasil Prediksi = Uncertain Configuration" crlf))

(defrule Cured
    (HBsAg negative)
    (anti-HBs positive)
    (anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Cured" crlf))

(defrule Vaccinated
    (HBsAg negative)
    (anti-HBs positive)
    (anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Vaccinated" crlf))

(defrule Unclear
    (HBsAg negative)
    (anti-HBs negative)
    (anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Unclear (possible resolved)" crlf))

(defrule Healthy
    (HBsAg negative)
    (anti-HBs negative)
    (anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Healthy not vaccinated or suspicious" crlf))