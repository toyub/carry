class Menu
  def self.candidate_shortcuts_for_staff(staff)
    works = self.all_menus_for(staff)
    shortcuts = staff.home_shortcuts || []
    works.each do |work|
      work[:sub_categories].delete_if{|link| shortcuts.include?(link[:idx].to_s) }
    end
    works
  end

  def self.all_menus_for(staff)
    $menus.deep_dup
  end

  def self.shortcuts_for(staff)
    shortcuts_idxs = staff.home_shortcuts || []
    my_works = []

    self.all_menus_for(staff).each do |root_category|
      root_category[:sub_categories].each do |work|
        if shortcuts_idxs.include?(work[:idx].to_s)
          my_works << work
        end
      end
    end
    
    my_works
  end
end
