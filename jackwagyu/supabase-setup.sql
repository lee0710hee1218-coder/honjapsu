-- 잭와규 무료 샘플 신청 테이블
-- Supabase 대시보드 > SQL Editor 에서 실행하세요.

create table if not exists public.sample_requests (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),

  -- 필수 항목
  store_name text not null,
  main_menu text not null,
  address text not null,
  contact_name text not null,
  phone text not null,
  daily_volume text not null,      -- 30그릇 미만 / 30~60 / 60~100 / 100 이상
  broth_method text not null,      -- 직접 제조 / 농축육수 / 본사 공급 / 기타
  interests text[] not null,       -- 순대국육수 / 국밥다데기 / 가공육 / 전체
  privacy_agreed boolean not null check (privacy_agreed),

  -- 선택 항목
  current_cost text,
  current_supplier text,
  question text,

  -- 유입 추적 (?source=NAVER_BLOG&campaign=CAMP-001)
  source text not null default 'DIRECT',
  campaign text,

  -- 영업 관리용 (HOT/WARM/COLD)
  grade text
);

-- 행 단위 보안 활성화 (기본적으로 모든 접근 차단)
alter table public.sample_requests enable row level security;

-- 익명 사용자(anon = publishable key)는 신청서를 "추가"만 할 수 있음
create policy "anon can insert sample_requests"
  on public.sample_requests
  for insert
  to anon
  with check (true);

-- 익명 사용자는 목록을 "조회"할 수 없음 (select 정책을 만들지 않으면 자동으로 차단됨)
