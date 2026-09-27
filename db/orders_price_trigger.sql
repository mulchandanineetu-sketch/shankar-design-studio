create or replace function orders_set_price()
returns trigger
language plpgsql
as $$
begin
  new.price := 500 + case new.size
    when 'L'  then 50
    when 'XL' then 100
    else 0
  end;
  return new;
end;
$$;

drop trigger if exists orders_set_price on orders;

create trigger orders_set_price
before insert or update on orders
for each row
execute function orders_set_price();
