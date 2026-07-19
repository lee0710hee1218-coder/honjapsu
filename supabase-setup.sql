-- 혼잡스 베타 알림 신청 테이블
-- Supabase 대시보드 > SQL Editor 에서 실행하세요.

create table if not exists public.waitlist (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  created_at timestamptz not null default now()
);

-- 행 단위 보안 활성화 (기본적으로 모든 접근 차단)
alter table public.waitlist enable row level security;

-- 익명 사용자(anon = publishable key)는 새 이메일을 "추가"만 할 수 있음
create policy "anon can insert waitlist"
  on public.waitlist
  for insert
  to anon
  with check (true);

-- 익명 사용자는 목록을 "조회"할 수 없음 (select 정책을 만들지 않으면 자동으로 차단됨)
