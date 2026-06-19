-- Juachi Pan — esquema de base de datos para Supabase
-- Pegá todo esto en: tu proyecto de Supabase > SQL Editor > New query > Run

create extension if not exists "pgcrypto";

create table orders (
  id uuid primary key default gen_random_uuid(),
  cliente text not null,
  pan text not null,
  cantidad numeric not null,
  precio numeric default 0,
  fecha date not null,
  notas text,
  estado text not null default 'pendiente',
  facturado boolean not null default false,
  created_at timestamptz default now()
);

create table expenses (
  id uuid primary key default gen_random_uuid(),
  insumo text not null,
  monto numeric not null,
  fecha date not null,
  created_at timestamptz default now()
);

create table incomes (
  id uuid primary key default gen_random_uuid(),
  pan text not null,
  cantidad numeric not null,
  precio numeric not null,
  total numeric not null,
  fecha date not null,
  created_at timestamptz default now()
);

-- Habilitamos RLS y permitimos acceso completo con la clave anónima.
-- Esto alcanza para un uso personal (vos sos el único que tiene el link y la clave),
-- pero cualquiera que tenga tu "anon key" podría leer o escribir datos.
-- Si vas a subir el código a un repositorio PÚBLICO de GitHub, tené en cuenta ese punto
-- (lo explico también en el README).

alter table orders enable row level security;
alter table expenses enable row level security;
alter table incomes enable row level security;

create policy "allow all orders" on orders for all using (true) with check (true);
create policy "allow all expenses" on expenses for all using (true) with check (true);
create policy "allow all incomes" on incomes for all using (true) with check (true);
