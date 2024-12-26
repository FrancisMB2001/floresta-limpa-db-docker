DO $$
DECLARE
  expected_count INT := 103;
  actual_count INT;
BEGIN
  -- Get the actual table count
  SELECT COUNT(*) INTO actual_count 
  FROM information_schema.tables 
  WHERE table_schema = 'public';

  -- Compare the actual and expected counts
  IF actual_count != expected_count THEN
    RAISE EXCEPTION 'Table count mismatch: expected %, found %', expected_count, actual_count;
  ELSE
    RAISE NOTICE 'Table count is as expected: %', actual_count;
  END IF;
END $$;