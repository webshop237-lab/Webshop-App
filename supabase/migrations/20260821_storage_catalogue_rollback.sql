-- Retour arrière du bucket catalogue — 21 août 2026
--
-- ATTENTION : retirer ces policies coupe l'upload d'images depuis le panneau
-- admin. Les images déjà déposées restent servies (bucket public en lecture).
-- Supprimer le bucket lui-même casserait toutes les fiches produits et
-- véhicules qui pointent vers ses URL : à ne faire qu'après avoir remis des
-- URL externes dans chaque fiche.

DROP POLICY IF EXISTS catalogue_insert_admin ON storage.objects;
DROP POLICY IF EXISTS catalogue_update_admin ON storage.objects;
DROP POLICY IF EXISTS catalogue_delete_admin ON storage.objects;
DROP POLICY IF EXISTS catalogue_select_admin ON storage.objects;

-- Suppression du bucket (décommenter en connaissance de cause) :
-- DELETE FROM storage.objects WHERE bucket_id = 'catalogue';
-- DELETE FROM storage.buckets WHERE id = 'catalogue';
