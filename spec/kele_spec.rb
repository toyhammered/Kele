require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do
    describe '#initialize' do

      it 'raises error' do
        expect { Kele.new(ENV['BLOC_EMAIL'], "fakefake") }.to raise_error(InvalidStudentCodeError)
      end

      it 'authenticates user' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        expect(response.instance_variable_get(:@auth_token)).to be_a String
      end

    end

    describe '#get_me' do
      it 'has all top level keys' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response = response.get_me
        keys = ["id", "slug", "name", "email", "title", "first_name", "last_name", "facebook_id", "url", "bio", "course", "current_enrollment", "quota", "quota_limit", "type", "status", "image_src", "large_image_src", "created_at", "facebook_profile_picture_url", "github_handle", "codecademy_handle", "time_zone"]
        keys.each do |key|
          expect(response).to include(key)
        end
      end

      it 'has important top level keys' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response = response.get_me
        keys = ["id", "name"]
        keys.each do |key|
          expect(response).to include(key)
        end
      end

      it 'keys nested under current_enrollment' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response = response.get_me
        keys = ["mentor_id"]
        keys.each do |key|
          expect(response["current_enrollment"]).to include(key)
        end
      end
    end

    describe '#get_mentor_availability' do
      it 'has all top level keys' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response.get_me
        mentor_availability = response.get_mentor_availability
        keys = ["id", "starts_at", "ends_at", "week_day", "booked"]
        keys.each do |key|
          expect(mentor_availability.first).to include(key)
        end
      end

    end

    describe '#get_roadmap' do
      it 'has all top level keys' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response.get_me
        get_roadmap = response.get_roadmap
        keys = ["projects", "id", "name", "level", "slug", "channel", "short_name", "sections"]
        keys.each do |key|
          expect(get_roadmap).to include(key)
        end
      end

    end

    describe '#get_checkpoint' do
      it 'has all top level keys for checkpoint 1' do
        response = Kele.new(ENV['BLOC_EMAIL'], ENV['BLOC_PASSWORD'])
        response.get_me
        get_checkpoint = response.get_checkpoint(1)
        keys = ["id", "name", "body", "parent_id", "created_at", "updated_at", "assignment", "summary", "points", "project_name", "roadmap_id", "active", "job_prep", "version", "body_file_path", "uuid", "ref", "retroactive_optional_date", "checkpoint_type"]
        keys.each do |key|
          expect(get_checkpoint).to include(key)
        end
      end

    end

  end

end
