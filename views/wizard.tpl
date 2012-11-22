%include header title='FutureMe'
<div class="hero-unit">
  <h2>Your Virtual Check Up</h2>
  <p>All the benefits of a visit to the doctor. None of the hassle.
  <p>Enter your information here, and we'll show you whether you are at an elevated risk for various diseases. Then, you can send this information to your doctor, and we'll also provide you with targetted recommendations on how to improve your health.
</div>

<div class="span14">
  <form action="/chart" method="post">
    <fieldset>
      <legend>Information</legend>
      <div class="clearfix">
        <label for="firstName">First Name</label>
        <div class="input">
          <input class="span" id="firstName" name="firstName" size="30" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="lastName">Last Name</label>
        <div class="input">
          <input class="span" id="lastName" name="lastName" size="30" type="text" />
        </div>
      </div><!-- /clearfix -->
        <div class="clearfix">
          <label id="genderOptionsRadio">Sex</label>
          <div class="input">
            <ul class="inputs-list">
              <li>
                <label>
                  <input type="radio" checked name="genderOptionsRadio" value="M" />
                  <span>Male</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="radio" name="genderOptionsRadio" value="F" />
                  <span>Female</span>
                </label>
              </li>
            </ul>
          </div>
        </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="ageField">Age</label>
        <div class="input">
          <input class="span" id="ageField" name="ageField" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="weightField">Weight</label>
        <div class="input">
          <input class="span" id="weightField" name="weightField" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="heightFeet">Height (ft.)</label>
        <div class="input">
          <input class="span" id="heightFeet" name="heightFeet" size="1" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="heightInches">(in.)</label>
        <div class="input">
          <input class="span" id="heightInches" name="heightInches" size="1" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="bloodPressureSystolic">Blood Pressure (sys.)</label>
        <div class="input">
          <input class="span" id="bloodPressureSystolic" name="bloodPressureSystolic" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <div class="clearfix">
        <label for="bloodPressureDiastolic">(dia.)</label>
        <div class="input">
          <input class="span" id="bloodPressureDiastolic" name="bloodPressureDiastolic" size="3" type="text" />
        </div>
      </div><!-- /clearfix -->
      <fieldset>
        <div class="clearfix">
          <label id="diseasesCheckboxes">Diseases</label>
          <div class="input">
            <ul class="inputs-list">
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="heartdisease" />
                  <span>Heart Disease</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="stroke" />
                  <span>Stroke</span>
                </label>
              </li>
              <li>
                <label>
                  <input type="checkbox" name="diseasesCheckboxes" value="kidneydisease" />
                  <span>Kidney Disease</span>
                </label>
              </li>
            </ul>
          </div>
        </div><!-- /clearfix -->
        <div class="clearfix">
          <label id="issmoker">Smoker?</label>
          <div class="input">
            <input type="checkbox" name="issmoker" value="issmoker" />
          </div>
        </div>
      </fieldset>
      <div class="actions">
        <button type="submit" class="btn primary large">Submit</button>
        <button type="reset" class="btn">Cancel</button>
      </div>
    </fieldset>
  </form>
</div>

<div class="row">
  <div class="span9">
    <h5>Practice Fusion</h5>
    <p>Are you a Practice Fusion patient? If so, just press the Practice Fusion button to the right, and you can skip filling out the form and go directly to your results.
  </div>
  <div class="span5">
    <a href="javascript:alert('Not implemented yet. Check back soon!')"><img src="/static/images/patient_fusion_logo.png" width="300" height="auto" alt="patient_fusion_connect"></a>
  </div>
</div>


%include footer

