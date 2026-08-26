-- Bucket catalogue + policies — 21 août 2026
--
-- Contexte : le panneau admin n'acceptait que des URL d'images tapées à la
-- main. L'upload depuis un téléphone ou un PC exige un espace de stockage.
--
-- Le bucket « catalogue » est public en LECTURE : les URL publiques des
-- images de produits et de véhicules doivent être servies aux visiteurs sans
-- authentification, exactement comme les URL Unsplash qu'elles remplacent.
-- La lecture publique d'un bucket public ne passe pas par RLS, aucune policy
-- SELECT n'est donc nécessaire pour l'affichage du catalogue.
--
-- L'ÉCRITURE est en revanche fermée à tout le monde sauf is_admin().
-- Sans cela, n'importe quel compte créé sur le site pourrait déposer des
-- fichiers dans le bucket avec la clé anon, qui est publique par nature.
-- C'est la même erreur que celle corrigée le 20 août sur les tables.
--
-- Retour arrière : 20260821_storage_catalogue_rollback.sql

CREATE POLICY catalogue_insert_admin ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'catalogue' AND public.is_admin());

CREATE POLICY catalogue_update_admin ON storage.objects
  FOR UPDATE TO authenticated
  USING (bucket_id = 'catalogue' AND public.is_admin())
  WITH CHECK (bucket_id = 'catalogue' AND public.is_admin());

CREATE POLICY catalogue_delete_admin ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id = 'catalogue' AND public.is_admin());

-- Nécessaire pour que l'admin puisse remplacer un fichier existant (upsert)
-- et vérifier ce qu'il a déposé. Reste fermé aux comptes non admin.
CREATE POLICY catalogue_select_admin ON storage.objects
  FOR SELECT TO authenticated
  USING (bucket_id = 'catalogue' AND public.is_admin());
