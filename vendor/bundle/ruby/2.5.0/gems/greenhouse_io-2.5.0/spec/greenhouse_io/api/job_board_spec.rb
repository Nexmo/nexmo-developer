require 'spec_helper'

describe GreenhouseIo::JobBoard do

  it "should have a base url for an API endpoint" do
    expect(GreenhouseIo::JobBoard.base_uri).to eq("https://api.greenhouse.io/v1")
  end

  context "given an instance of GreenhouseIo::JobBoard" do

    before do
      GreenhouseIo.configuration.symbolize_keys = true
      @client = GreenhouseIo::JobBoard.new('123FakeToken', organization: 'generalassembly')
    end

    describe "#initialize" do
      it "has an api_token" do
        expect(@client.api_token).to eq('123FakeToken')
      end

      it "has an organization" do
        expect(@client.organization).to eq('generalassembly')
      end

      it "uses the configuration value when token is not specified" do
        GreenhouseIo.configuration.api_token = '123FakeENV'
        default_client = GreenhouseIo::JobBoard.new
        expect(default_client.api_token).to eq('123FakeENV')
      end
    end

    context "when an organization has not been set" do
      it "raises an 'organization can't be blank' error" do
        no_org_client = GreenhouseIo::JobBoard.new
        expect{ no_org_client.offices }.to raise_error(GreenhouseIo::Error)
      end
    end

    context "when an invalid organization is used" do
      it "raises an HTTP Error" do
        VCR.use_cassette('invalid_organization') do
          invalid_org_client = GreenhouseIo::JobBoard.new(nil, organization: 'not-real-inc')
          expect{ invalid_org_client.offices }.to raise_error(GreenhouseIo::Error)
        end
      end
    end

    context "when an invalid id is used" do
      it "raises an HTTP Error" do
        VCR.use_cassette('invalid_id') do
          expect{ @client.job(123) }.to raise_error(GreenhouseIo::Error)
        end
      end
    end

    describe "#offices" do
      it "grabs the latest jobs and departments for an organization by each office" do
        VCR.use_cassette('offices') do
          offices_hash_response = @client.offices
          expect(offices_hash_response).to_not be_nil
          expect(offices_hash_response[:offices]).to be_an_instance_of(Array)
        end
      end
    end

    describe "#office" do
      it "grabs the latest jobs and deparments for a specific office" do
        VCR.use_cassette('office') do
          office_hash_response = @client.office(0)
          expect(office_hash_response).to_not be_nil
          expect(office_hash_response).to include(:id => 0)
          expect(office_hash_response).to include(:name => 'No Office')
          expect(office_hash_response[:departments]).to be_an_instance_of(Array)
        end
      end
    end

    describe "#departments" do
      it "returns a list of an organization's departments and jobs" do
        VCR.use_cassette('departments') do
          departments_hash_response = @client.departments
          expect(departments_hash_response).to_not be_nil
          expect(departments_hash_response[:departments]).to be_an_instance_of(Array)
        end
      end
    end

    describe "#department" do
      it "returns a list of jobs for a specific department" do
        VCR.use_cassette('department') do
          department_hash_response = @client.department(187)
          expect(department_hash_response).to_not be_nil
          expect(department_hash_response).to include(:id => 187)
          expect(department_hash_response).to include(:name => 'Engineering')
          expect(department_hash_response[:jobs]).to be_an_instance_of(Array)
        end
      end
    end

    describe "#jobs" do
      it "returns the list of all jobs" do
        VCR.use_cassette('jobs') do
          jobs_hash_response = @client.jobs
          expect(jobs_hash_response).to_not be_nil
          expect(jobs_hash_response[:jobs]).to be_an_instance_of(Array)
        end
      end

      it "returns a list of jobs and their job descriptions" do
        VCR.use_cassette('jobs_with_content') do
          jobs_description_hash_response = @client.jobs(:content => true)
          expect(jobs_description_hash_response).to_not be_nil
          expect(jobs_description_hash_response[:jobs]).to be_an_instance_of(Array)
          expect(jobs_description_hash_response[:jobs].first).to include(:content)
        end
      end
    end

    describe "#job" do
      it "returns the details for a specific job by ID" do
        VCR.use_cassette('job') do
          job_hash_response = @client.job(721)
          expect(job_hash_response).to_not be_nil
          expect(job_hash_response).to include(:id => 721)
          expect(job_hash_response).to include(:content)
        end
      end

      it "returns the details for a specific job and its application questions" do
        VCR.use_cassette('job_with_questions') do
          job_with_questions_hash_response = @client.job(721, :questions => true)
          expect(job_with_questions_hash_response).to_not be_nil
          expect(job_with_questions_hash_response).to include(:id => 721)
          expect(job_with_questions_hash_response).to include(:content)
          expect(job_with_questions_hash_response[:questions]).to be_an_instance_of(Array)
        end
      end
    end

    describe "#apply_to_job" do
      it "posts an application to a specified job" do
        VCR.use_cassette('apply_to_job') do
            apply_to_job = @client.apply_to_job(
              {
                :id => 721,
                :first_name => 'Richard',
                :last_name => 'Feynman',
                :email => 'richard123@test.ga.co'
              }
            )
          expect(apply_to_job).to_not be_nil
          expect(apply_to_job).to include(:success => 'Candidate saved successfully')
        end
      end

      it "errors when missing required fields" do
        VCR.use_cassette('invalid_application') do
          expect {
            @client.apply_to_job(
              {
                :id => 721,
                :question_2720 => 'not_required'
              }
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end

      it "errors when given an invalid ID" do
        VCR.use_cassette('invalid_application_id') do
          expect {
            @client.apply_to_job(
              {
                :id => 456,
                :first_name => 'Gob',
                :last_name => 'Bluth',
                :email => 'gob@bluth.com'
              }
            )
          }.to raise_error(GreenhouseIo::Error)
        end
      end
    end

  end

end
