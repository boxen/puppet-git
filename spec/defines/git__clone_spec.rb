
require 'spec_helper'

describe 'git::clone' do
  let(:boxenhome) { '/opt/boxen' }
  let(:params){ {:path => '/Users/user/my_space' } }
  let(:facts) do
    {
      :boxen_home => boxenhome,
      :boxen_user => 'pcollins',
      :luser      => 'paulcollins',
    }
  end

  describe "with invalid name" do
    let(:title){ 'https://test.com/user/repo_name/' }
    it{ expect { should contain_exec("git clone #{title}") }.to raise_error(Puppet::Error)}
  end

  describe "with valid name" do
    let(:title){ 'https://test.com/user/repo_name' }
    it do
      should contain_exec("git clone #{title}").with({
        :command => "hub clone #{title} #{params[:path]}/repo_name",
        :creates => "#{params[:path]}/repo_name",
        :cwd     => "#{params[:path]}",
        :path    => "#{boxenhome}/homebrew/bin",
        :user    => "#{facts[:luser]}",

      })
    end
  end

  describe "with valid name ending in .git" do
    let(:title){ 'https://test.com/user/repo_name.git' }
    it do
      should contain_exec("git clone #{title}").with({
        :command => "hub clone #{title} #{params[:path]}/repo_name",
        :creates => "#{params[:path]}/repo_name",
        :cwd     => "#{params[:path]}",
        :path    => "#{boxenhome}/homebrew/bin",
        :user    => "#{facts[:luser]}",

      })
    end
  end

  describe "with non-https style repo" do
    let(:title){ 'git@github.com:user/repo_name.git' }
    it do
      should contain_exec("git clone #{title}").with({
        :command => "hub clone #{title} #{params[:path]}/repo_name",
      })
    end
  end

end
