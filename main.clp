(defrule is-HBsAG
    =>
    (printout t "HBsAG? ")
    (assert (HBsAG(read))))

(defrule is-anti-HDV
    (HBsAG positive)
    =>
    (printout t "anti-HDV? ")
    (assert (anti-HDV(read))))

(defrule Hepatitis-B+D 
    (anti-HDV positive)
    =>
    (printout t crlf "Hasil Prediksi = Hepatitis B+D" crlf))

(defrule is-anti-HBc
    (or 
        (anti-HDV negative)
        (and (HBsAG negative) (anti-HBs ?))
    )
    =>
    (printout t "anti-HBc? ")
    (assert (anti-HBc(read))))

(defrule is-anti-HBs
    (or
        (and (anti-HBc positive) (HBsAG positive))
        (HBsAG negative)
    )
    =>
    (printout t "anti-HBs? ")
    (assert (anti-HBs(read))))

(defrule is-IgM-anti-HBc
    (HBsAG positive)
    (anti-HBs negative)
    =>
    (printout t "IgM anti-HBc? ")
    (assert (IgM-anti-HBc(read))))

(defrule Acute-infection
    (IgM-anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Acute infection" crlf))

(defrule Chronic-infection
    (IgM-anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Chronic infection" crlf))

(defrule Uncertain-configuration
    (HBsAG positive)
    (or (anti-HBc negative) (anti-HBs positive))
    =>
    (printout t crlf "Hasil Prediksi = Uncertain Configuration" crlf))

(defrule Cured
    (HBsAG negative)
    (anti-HBs positive)
    (anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Cured" crlf))

(defrule Vaccinated
    (HBsAG negative)
    (anti-HBs positive)
    (anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Vaccinated" crlf))

(defrule Unclear
    (HBsAG negative)
    (anti-HBs negative)
    (anti-HBc positive)
    =>
    (printout t crlf "Hasil Prediksi = Unclear (possible resolved)" crlf))

(defrule Healthy
    (HBsAG negative)
    (anti-HBs negative)
    (anti-HBc negative)
    =>
    (printout t crlf "Hasil Prediksi = Healthy not vaccinated or suspicious" crlf))