-- Retour arrière de la colonne avatar — 26 août 2026
--
-- ATTENTION : supprimer cette colonne efface les photos des personnes qui
-- témoignent, y compris celles déposées depuis le panneau admin. Le carrousel
-- retombera sur l'initiale du prénom, sans image. Les fichiers correspondants
-- resteront dans le bucket « catalogue » sans que rien ne les référence.

ALTER TABLE public.testimonials DROP COLUMN IF EXISTS avatar;
