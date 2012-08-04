require 'spec_helper'

describe Object do
  
  describe '.underscore' do
    
    it "no namespace" do
      class ObjectFoo;end
      Object.underscore.should == 'object'
      ObjectFoo.underscore.should == 'object_foo'
    end
    
    it "namespace" do
      module MyMod; class MyClass; end; end
      MyMod::MyClass.underscore.should == 'my_mod_my_class'
    end
  end
  
  describe '.demodulize_underscore' do
    it "no namespace" do
      class ObjectFoo;end
      Object.demodulize_underscore.should == 'object'
      ObjectFoo.demodulize_underscore.should == 'object_foo'
    end
    
    it "namespace" do
      module MyMod; class MyClass; end; end
      MyMod::MyClass.demodulize_underscore.should == 'my_class'
    end
  end
  
end