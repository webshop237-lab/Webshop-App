-- Table des forfaits WEBMARKET — 26 août 2026
--
-- Contexte : les trois forfaits affichés dans la section Tarifs vivaient dans
-- les traductions STR de index.html, en français et en anglais. Changer un
-- prix demandait de modifier le fichier et de redéployer. Ils passent en base
-- pour que le panneau admin puisse les gérer.
--
-- Les deux langues sont portées par la même ligne : un forfait est un forfait,
-- seuls son nom, son prix affiché, sa description et ses avantages changent
-- d'une langue à l'autre. Le tag et l'unité sont communs.
--
-- « price » est du texte et non un nombre : la grille affiche aussi bien
-- « 150 000 » que « Sur devis ».
--
-- « features » est du texte multiligne, un avantage par ligne. Un tableau
-- Postgres serait plus propre en théorie, mais le panneau admin édite ce champ
-- dans une zone de texte : garder la même forme des deux côtés évite une
-- conversion à chaque aller-retour.
--
-- Retour arrière : 20260826_packages_rollback.sql

CREATE TABLE IF NOT EXISTS public.packages (
  id          bigint PRIMARY KEY,
  position    integer NOT NULL DEFAULT 0,
  tag         text    NOT NULL DEFAULT '',
  unit        text    NOT NULL DEFAULT '',
  popular     boolean NOT NULL DEFAULT false,
  visible     boolean NOT NULL DEFAULT true,
  name_fr     text    NOT NULL DEFAULT '',
  name_en     text    NOT NULL DEFAULT '',
  price_fr    text    NOT NULL DEFAULT '',
  price_en    text    NOT NULL DEFAULT '',
  desc_fr     text    NOT NULL DEFAULT '',
  desc_en     text    NOT NULL DEFAULT '',
  features_fr text    NOT NULL DEFAULT '',
  features_en text    NOT NULL DEFAULT ''
);

ALTER TABLE public.packages ENABLE ROW LEVEL SECURITY;

-- Lecture ouverte à tous : la grille tarifaire est affichée aux visiteurs.
CREATE POLICY packages_read_public ON public.packages
  FOR SELECT TO anon, authenticated
  USING (true);

-- Écriture réservée à l'administrateur, comme pour le reste du catalogue.
CREATE POLICY packages_write_admin ON public.packages
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Les trois forfaits en place, repris des traductions du fichier.
INSERT INTO public.packages (id, position, tag, unit, popular, visible,
                             name_fr, name_en, price_fr, price_en,
                             desc_fr, desc_en, features_fr, features_en)
VALUES
  (1, 1, 'STARTER', 'FCFA', false, true,
   'Vitrine', 'Showcase', '150 000', '150 000',
   'Site vitrine professionnel pour présenter votre activité.',
   'Professional marketing site to present your business.',
   E'Jusqu''à 5 pages
Design responsive
Formulaire de contact
Optimisation mobile
Mise en ligne incluse',
   E'Up to 5 pages
Responsive design
Contact form
Mobile optimization
Launch included'),
  (2, 2, 'PRO', 'FCFA', true, true,
   'Business', 'Business', '350 000', '350 000',
   'Application web sur-mesure avec fonctionnalités avancées.',
   'Custom web application with advanced features.',
   E'Pages illimitées
Espace administrateur
Intégration WhatsApp & paiement
SEO de base
Maintenance 1 mois offerte',
   E'Unlimited pages
Admin dashboard
WhatsApp & payment integration
Basic SEO
1 month maintenance included'),
  (3, 3, 'ENTERPRISE', '', false, true,
   'Sur-mesure', 'Custom', 'Sur devis', 'Custom quote',
   'Application mobile ou plateforme complexe selon vos besoins.',
   'Mobile app or complex platform tailored to your needs.',
   E'Cahier des charges dédié
Web & mobile
Intégrations API
Formation de votre équipe
Support prioritaire',
   E'Dedicated specs
Web & mobile
API integrations
Team training
Priority support')
ON CONFLICT (id) DO NOTHING;
