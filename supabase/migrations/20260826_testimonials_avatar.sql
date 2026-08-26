-- Colonne avatar sur testimonials — 26 août 2026
--
-- Contexte : la page d'accueil affiche la photo de la personne qui témoigne,
-- mais cette photo n'existait que dans la constante TESTIMONIALS du fichier
-- index.html. La table, elle, n'avait pas de colonne pour la porter.
--
-- Tant que le carrousel lisait la constante, ça ne se voyait pas. Maintenant
-- qu'il lit la table, une colonne manquante voudrait dire quatre avatars
-- cassés en production. On l'ajoute donc, et on y recopie les URL en place.
--
-- Retour arrière : 20260826_testimonials_avatar_rollback.sql

ALTER TABLE public.testimonials ADD COLUMN IF NOT EXISTS avatar text;

UPDATE public.testimonials SET avatar =
  'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200&q=80&auto=format&fit=crop&crop=faces'
  WHERE id = 1 AND avatar IS NULL;
UPDATE public.testimonials SET avatar =
  'https://images.unsplash.com/photo-1545167622-3a6ac756afa4?w=200&q=80&auto=format&fit=crop&crop=faces'
  WHERE id = 2 AND avatar IS NULL;
UPDATE public.testimonials SET avatar =
  'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&q=80&auto=format&fit=crop&crop=faces'
  WHERE id = 3 AND avatar IS NULL;
UPDATE public.testimonials SET avatar =
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80&auto=format&fit=crop&crop=faces'
  WHERE id = 4 AND avatar IS NULL;
